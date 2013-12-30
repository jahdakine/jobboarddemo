#Logging in/out session REST actions
class SessionsController < ApplicationController
  include Roles

  skip_before_filter :authenticate

  #login
  def new
    if (current_user)
      flash.now[:notice] = "Your session has timed out"
      redirect_to logout_path
    end
  end

  #login handler
  def create
    #Honey pot for bots - if filled,
    #redirect and make registration appear successful
      #http://www.sitepoint.com/easy-spam-prevention-using-hidden-form-fields/
    if !params[:vip].empty?
      redirect_to "http://buildinglivablecommunities.org/"
    else
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        token = @user.auth_token
        if params[:remember_me]
          cookies.permanent[:auth_token] = token
          # cookies[:auth_token] = {
          #   :value => token,
          #   :expires => 2.weeks.from_now
          # }
        else
          cookies[:auth_token] = token
        end
        role_router #Roles module
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end
  end

  #logout handler
  def destroy
    cookies.delete(:auth_token)
    redirect_to login_path, :notice => "
    You have been logged out for one of the following reasons:
    <ul style='text-align:left;list-style:square'>
    <li>You requested it via log out link</li>
    <li>Your session has timed out</li>
    <li>You requested an unauthorized action</li>
    <li>You requested the log in page while logged in</li>
    </ul>"
  end
end