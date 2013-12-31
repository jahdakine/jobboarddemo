#Job Openings REST actions
class OpeningsController < ApplicationController
  include Roles

  before_action :set_opening, only: [:edit, :update, :destroy]
  before_action :set_interests, only: [:index, :new, :create, :edit, :update]
  before_action :set_saved, only: [:index, :saved]
  before_action :set_faved, only: [:index, :faved]

  before_action :is_admin_or_np, only: [:edit, :update, :destroy]
  before_action :is_employer, only: [:new, :create]
  before_action :is_member, only: [:add, :remove, :saved, :faved]
  #all: [:index, :show]

  ###GET /opening
  def index
    #TODO: This is a first pass to get it to work. Please refactor -
    #move to a scoped search or a method in model!
    cur_time = Time.now
    cur_user = current_user.role_id
    ints = params[:interests]
    if ints.present?
      @selected_interests = ints
      paramsPresent = true
    else
      @selected_interests = []
      paramsPresent = false
    end
    if current_role(Employer)
      if paramsPresent
        @openings = Opening.find_by_sql([
          "SELECT openings.* FROM openings
          LEFT JOIN categorizations ON categorizations.opening_id = openings.id
          LEFT JOIN interests ON interests.id = categorizations.interest_id
          WHERE 0=0
          AND interests.id IN (?)
          AND employer_id = ?
          GROUP BY openings.id",
          ints, cur_user
        ])
      else
        @openings = Opening.find_by_sql([
          "SELECT openings.* FROM openings
          WHERE 0=0
          AND employer_id = ?",
          cur_user
        ])
      end
    elsif current_role(Member)
      @top5openings = Opening.find_by_sql(
        'SELECT views_count, id, position
        FROM openings
        ORDER BY views_count DESC, position
        LIMIT 5'
      )
      if paramsPresent
        @openings = Opening.find_by_sql([
          "SELECT openings.*, employers.company, employers.id as nid
          FROM openings
          LEFT JOIN categorizations ON categorizations.opening_id = openings.id
          INNER JOIN employers ON openings.employer_id = employers.id
          LEFT JOIN interests ON interests.id = categorizations.interest_id
          WHERE 0=0
          AND interests.id IN (?)
          AND active = ?
          AND date_open < ?
          AND date_closed > ?
          GROUP BY openings.id, employers.company, employers.id",
          ints, true, cur_time, cur_time
        ])
      else
        @openings = Opening.find_by_sql([
          "SELECT openings.*, employers.company, employers.id as nid
          FROM openings
          LEFT JOIN categorizations ON categorizations.opening_id = openings.id
          INNER JOIN employers ON openings.employer_id = employers.id
          LEFT JOIN interests ON interests.id = categorizations.interest_id
          WHERE 0=0
          AND active = ?
          AND date_open < ?
          AND date_closed > ?
          GROUP BY openings.id, employers.company, employers.id",
          true, cur_time, cur_time
        ])
      end
    else
      @openings = Opening.all
    end
    back_search_w_params(openings_path)
  end

  ###GET /openings/1
  def show
    pid = params[:id]
    @opening = Opening.includes(:employer).find(pid)
    @selected_interests = @opening.interests.to_a
    Opening.increment_counter :views_count, pid
    if current_role(Member)
      qry = Opening.find_by_sql([
        "SELECT openings.id FROM openings
        LEFT OUTER JOIN applications ON applications.opening_id = openings.id
        WHERE applications.member_id = ?",
        current_user.role_id
      ])
      @selected_applications = qry.collect(&:id)
    end
  end

  ###GET /openings/new
  def new
    @opening = Opening.new
    @selected_interests = []
    @employer = Employer.find(current_user.role_id)
  end

  ###POST /openings
  def create
    @opening = Opening.new(opening_params)
    if @opening.save
      redirect_to @opening, notice: 'Job opening successfully created.'
    else
      @selected_interests = params[:opening][:interest_ids] ||= []
      @employer = Employer.find(current_user.role_id)
      render 'new'
    end
  end

  ###GET /openings/1/edit
  def edit
    @selected_interests = @opening.interest_ids.to_a.map!(&:to_s)
    if current_role(Admin)
      @employer = Employer.find(@opening.employer_id)
    else
      @employer = Employer.find(current_user.role_id)
    end
  end

  ###PATCH/PUT /openings/1
  def update
    params[:opening][:interest_ids] ||= [] #if no boxes are checked
    if @opening.update(opening_params)
      redirect_to @opening, notice: 'Job opening successfully updated.'
    else
      @selected_interests = params[:opening][:interest_ids] ||= []
      @employer = Employer.find(current_user.role_id)
      render 'edit'
    end
  end

  ###DELETE /openings/1
  def destroy
    @opening.destroy
    redirect_to openings_url, notice: 'Job opening successfully deleted.'
  end

  ###Non-RESTful misc actions
  #Member adds Opening to saved jobs list
  def add
    pid = params[:id]
    cur_user = current_user.role_id
    if Member.find(cur_user)
      .applications
      .create(:member_id=>cur_user, :opening_id=>pid)
      flash[:notice] = 'Opening added to Saved Jobs!'
    else
      flash[:alert] = 'There was a problem adding opening to Saved Jobs.'
    end
    redirect_to opening_path(pid)
  end

  #Member removes Opening from saved jobs list
  def remove
    pid = params[:id]
    @id = Application.find_by_sql([
      "SELECT id
      FROM applications
      WHERE member_id = ?
      AND opening_id = ?",
      current_user.role_id, pid
    ])
    if Application.delete(@id)
      flash[:notice] = 'Opening removed from Saved Jobs!'
    else
      flash[:alert] = 'There was a problem removing opening from Saved Jobs.'
    end
    redirect_to opening_path(pid)
  end

  #Get Saved list
  def saved
  end

  #Get Faved list
  def faved
  end

  #Removes openings with past date closed dates
  def close
    if Opening.remove_stale_openings
      redirect_to referrer, notice: 'Operation successful'
    else
      redirect_to referrer, alert: 'Operation unsuccessful'
    end
  end

  private
    ###Use callbacks to share common setup or constraints between actions.
    #retreives the opening by requested parameter
    #IF it is owned by the current NP
    #OR current role is member AND it exists
    def set_opening
      pid = params[:id]
      if Opening.exists?(pid)
        @opening = Opening.find(pid)
        if current_role(Employer)
          if @opening.employer_id != current_user.role_id || !@opening
            redirect_to openings_path, :alert => "Insufficient priviledges!"
          end
        end
      else
        redirect_to openings_path,
          :alert => "Unable to find Opening with ID #{pid}!"
      end
    end
    def set_interests
      @interests = Interest.all.order('name ASC')
    end
    def set_saved
      @saved = Opening.includes(:applications, :employer)
        .where('applications.member_id = ?', current_user.role_id)
        .references(:applications, :employer)
    end
    def set_faved
      @faved = Employer.includes(:favoriteds)
        .where('favoriteds.member_id = ?', current_user.role_id)
        .references(:favoriteds)
    end
    ###Never trust parameters from the scary internet,
    #only allow the white list through.
    def opening_params
      params.require(:opening).permit(
        :active,
        :city,
        :state,
        :zip_code,
        :date_open,
        :date_closed,
        :description,
        :position,
        :employer_id,
        :interest_ids => []
      )
    end
  #end private
end