#Nonprofit user REST actions
class NonprofitsController < ApplicationController
  include Roles

  before_action :set_nonprofit, only: [:edit, :update, :destroy]

  before_action :is_admin, only: [:index, :new, :create, :destroy]
  before_action :is_admin_or_np, only: [:show, :edit, :update]
  before_action :is_graduate, only: [:display, :add, :remove, :faved]

  ###GET /nonprofits
  def index
    @nonprofits = Nonprofit.includes(:user)
  end

  ##GET /nonprofits/1
  def show
    @nonprofit = Nonprofit.includes(:user).find(params[:id])
    @openings = @nonprofit.openings
  end

  ###GET /nonprofits/new
  def new
    @user = User.new
  end

  ###POST /nonprofits
  def create
    @user = User.new(user_params)
    @user.generate_token(:password_reset_token)
    #Only nonprofits will be registered from the new form
    @user.role = Nonprofit.new()
    if @user.save
      #TODO: remove if when email ready on production
      @user.send_invitation_welcome if Rails.env.development?
      redirect_to nonprofits_path,
        notice: 'Employer successfully created and email invitation sent.'
    else
      render 'new'
    end
  end

  #profile
  ###GET /nonprofits/1/edit
  def edit
  end

  #profile handler
  ###PATCH/PUT /graduates/1
  def update
    if @nonprofit.update(nonprofit_params)
      redirect_to edit_nonprofit_path(@nonprofit),
        notice: 'Profile successfully updated.'
    else
      render 'edit'
    end
  end

  ###DELETE /nonprofit/1
  def destroy
    @nonprofit.destroy
    redirect_to nonprofits_path, notice: 'Employer deleted successfully.'
  end

  ###Non-RESTful actions
  #Graduate adds Nonprofit to faved list
  def add
    cur_user = current_user.role_id
    pid = params[:id]
    if Graduate.find(cur_user).favoriteds.create(
      :graduate_id=>cur_user, :nonprofit_id=>pid
    )
      flash[:notice] = 'Employer added to Faved list!'
    else
      flash[:alert] = 'There was a problem adding Employer to Faved list.'
    end
    redirect_to :action => 'display', :id =>(pid)
  end

  #Graduate removes Nonprofit from faved list
  def remove
    pid = params[:id]
    @id = Favorited.find_by_sql([
      "SELECT id
      FROM favoriteds
      WHERE graduate_id = ?
      AND nonprofit_id = ?",
      current_user.role_id, pid
    ])
    if Favorited.delete(@id)
      flash[:notice] = 'Employer removed from Faved list!'
    else
      flash[:alert] = 'There was a problem removing Employer from Faved list.'
    end
    redirect_to :action => 'display', :id =>(pid)
  end

  #For Graduates to view profile info
  def display
    @nonprofit = Nonprofit.find(params[:id])
    qry = Opening.find_by_sql([
      "SELECT nonprofits.id FROM nonprofits
      LEFT OUTER JOIN favoriteds ON favoriteds.nonprofit_id = nonprofits.id
      WHERE favoriteds.graduate_id = ?",
      current_user.role_id
    ])
    @selected_favoriteds = qry.collect(&:id)
  end

  #Get Faved list
  def faved
    #Not sure why the below doesnt work?
    #@faved = Nonprofit.includes(:favoriteds, :user)
    #.where('favoriteds.graduate_id = ?', current_user.role_id)
    #.references(:favoriteds, :user)
    @faved = Nonprofit.find_by_sql([
      "SELECT nonprofits.*, users.email FROM nonprofits
      LEFT OUTER JOIN favoriteds ON favoriteds.nonprofit_id = nonprofits.id
      INNER JOIN users ON users.role_id = nonprofits.id
      WHERE favoriteds.graduate_id = ?
      GROUP BY nonprofits.id",
      current_user.role_id
    ])
  end

  private
    ###Use callbacks to share common setup or constraints between actions.
    #Retreives the opening by requested parameter
    #IF it is owned by the current NP AND it exists
    def set_nonprofit
      pid = params[:id]
      if Nonprofit.exists?(pid)
        @nonprofit = Nonprofit.find(pid)
        if (
          !current_role(Admin) &&
          (@nonprofit.id != current_user.role_id) ||
          !@nonprofit
        )
          print "\n\nset_nonprofit not current user\n\n"
          redirect_to logout_path
        end
      else
        redirect_to logout_path
      end
    end
    ###Never trust parameters from the scary internet,
    #only allow the white list through.
    def nonprofit_params
      params.require(:nonprofit).permit(
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