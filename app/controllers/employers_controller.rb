#Employer user REST actions
class EmployersController < ApplicationController
  include Roles

  before_action :set_employer, only: [:edit, :update, :destroy]

  before_action :is_admin, only: [:index, :new, :create, :destroy]
  before_action :is_admin_or_np, only: [:show, :edit, :update]
  before_action :is_member, only: [:display, :add, :remove, :faved]

  ###GET /employers
  def index
    @employers = Employer.includes(:user)
  end

  ##GET /employers/1
  def show
    @employer = Employer.includes(:user).find(params[:id])
    @openings = @employer.openings
  end

  ###GET /employers/new
  def new
    @user = User.new
  end

  ###POST /employers
  def create
    @user = User.new(user_params)
    @user.generate_token(:password_reset_token)
    #Only employers will be registered from the new form
    @user.role = Employer.new()
    if @user.save
      #TODO: remove if when email ready on production
      @user.send_invitation_welcome if Rails.env.development?
      redirect_to employers_path,
        notice: 'Employer successfully created and email invitation sent.'
    else
      render 'new'
    end
  end

  #profile
  ###GET /employers/1/edit
  def edit
  end

  #profile handler
  ###PATCH/PUT /members/1
  def update
    if @employer.update(employer_params)
      redirect_to edit_employer_path(@employer),
        notice: 'Profile successfully updated.'
    else
      render 'edit'
    end
  end

  ###DELETE /employer/1
  def destroy
    @employer.destroy
    redirect_to employers_path, notice: 'Employer deleted successfully.'
  end

  ###Non-RESTful actions
  #Member adds Employer to faved list
  def add
    cur_user = current_user.role_id
    pid = params[:id]
    if Member.find(cur_user).favoriteds.create(
      :member_id=>cur_user, :employer_id=>pid
    )
      flash[:notice] = 'Employer added to Faved list!'
    else
      flash[:alert] = 'There was a problem adding Employer to Faved list.'
    end
    redirect_to :action => 'display', :id =>(pid)
  end

  #Member removes Employer from faved list
  def remove
    pid = params[:id]
    @id = Favorited.find_by_sql([
      "SELECT id
      FROM favoriteds
      WHERE member_id = ?
      AND employer_id = ?",
      current_user.role_id, pid
    ])
    if Favorited.delete(@id)
      flash[:notice] = 'Employer removed from Faved list!'
    else
      flash[:alert] = 'There was a problem removing Employer from Faved list.'
    end
    redirect_to :action => 'display', :id =>(pid)
  end

  #For Members to view profile info
  def display
    @employer = Employer.find(params[:id])
    qry = Opening.find_by_sql([
      "SELECT employers.id FROM employers
      LEFT OUTER JOIN favoriteds ON favoriteds.employer_id = employers.id
      WHERE favoriteds.member_id = ?",
      current_user.role_id
    ])
    @selected_favoriteds = qry.collect(&:id)
  end

  #Get Faved list
  def faved
    #Not sure why the below doesnt work?
    #@faved = Employer.includes(:favoriteds, :user)
    #.where('favoriteds.member_id = ?', current_user.role_id)
    #.references(:favoriteds, :user)
    @faved = Employer.find_by_sql([
      "SELECT employers.*, users.email FROM employers
      LEFT OUTER JOIN favoriteds ON favoriteds.employer_id = employers.id
      INNER JOIN users ON users.role_id = employers.id
      WHERE favoriteds.member_id = ?
      GROUP BY employers.id",
      current_user.role_id
    ])
  end

  private
    ###Use callbacks to share common setup or constraints between actions.
    #Retreives the opening by requested parameter
    #IF it is owned by the current NP AND it exists
    def set_employer
      pid = params[:id]
      if Employer.exists?(pid)
        @employer = Employer.find(pid)
        if (
          !current_role(Admin) &&
          (@employer.id != current_user.role_id) ||
          !@employer
        )
          print "\n\nset_employer not current user\n\n"
          redirect_to logout_path
        end
      else
        redirect_to logout_path
      end
    end
    ###Never trust parameters from the scary internet,
    #only allow the white list through.
    def employer_params
      params.require(:employer).permit(
        :company,
        :description,
        :city,
        :state,
        :zip_code,
        :skip
      )
    end
    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :force_reset
      )
    end
  #end private
end