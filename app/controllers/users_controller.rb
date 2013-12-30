#User REST actions
class UsersController < ApplicationController
  include Roles

  skip_before_filter :authenticate, only: [:new, :create]
  before_action :is_admin, only: [:index, :destroy]

  #graduates listing
  ### GET /graduates
  def index
    @users = User.all.includes(:role => :user)
  end

  #register
  ###GET /users/new
  def new
    @user = User.new
  end

  #register handler
  ###POST /users
  def create
    #Honey pot for bots - if filled,
    #redirect and make registration appear successful
      #http://www.sitepoint.com/easy-spam-prevention-using-hidden-form-fields/
    if !params[:vip].empty?
      redirect_to login_path, notice: "Thank you for registering"
    else
      @user = User.new(user_params)
      @user.skip_password = false
      #Only graduates will be registering from the new form
      @user.role = Graduate.new()
      if @user.save
        cookies[:auth_token] = @user.auth_token
        @user.send_registration_welcome if Rails.env.development?
        redirect_to edit_graduate_path(@user.role_id),
        notice: "Thank you for registering - please complete your profile"
      else
        render "new"
      end
    end
  end

  ##DELETE /interests/1
  def destroy
    @user = User.find(params[:id])
    rtype = @user.role_type
    rid = @user.role.id
    if rtype == 'Graduate'
      @grad = Graduate.find(rid)
      @grad.destroy
    elsif rtype == 'Nonprofit'
      @np = Nonprofit.find(rid)
      @np.destroy
    end
    redirect_to users_url, notice: "User successfully deleted."
  end

  ###Non-RESTful actions
  #Removes registered users over 1 month old with incomplete profiles
  def purge
    if User.remove_stale_registrations
      redirect_to referrer, notice: 'Operation successful'
    else
      redirect_to referrer, alert: 'Operation unsuccessful'
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :agreement
      )
    end
  #end private
end
