#Resetting password REST actions
class PasswordResetsController < ApplicationController
  skip_before_filter :authenticate

  #reset request form
  def new
  end

  #reset request form handler
  def create
    pemail = params[:email]
    #Honey pot for bots - if filled, redirect and make
    #registration appear successful
      #http://www.sitepoint.com/easy-spam-prevention-using-hidden-form-fields/
    if !params[:vip].empty?
      redirect_to root_url
    else
      if !pemail.present?
        flash.now[:alert] = 'Email is required!'
        render 'new'
      else
        user = User.find_by_email(pemail)
        if user
          #TODO: remove after && when email ready on prod
          user.send_password_reset if user && Rails.env.development?
        end
        redirect_to root_url,
          :notice => "Email sent with password reset instructions."
      end
    end
  end

  #reset form
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    (@user.force_reset ? @forced = true : @forced = false)
  end

  #reset form handler
  def update
    rid = @user.role_id
    rtype = @user.role_type
    pold = params[:old_password]
    @user = User.find_by_password_reset_token!(params[:id])
    if pold
      @user.check_password = true
      @user.old_password = pold
      @user.current_password = @user.password_digest
      @forced = true
      #Rails.logger.info(@user.old_password)
    else
      if @user.password_reset_sent_at < 2.hours.ago
        redirect_to new_password_reset_path,
          :alert => "Password reset has expired."
      end
    end
    if @user.update(user_params)
      if !(current_user)
        user_path = root_path
      elsif rtype == 'Admin'
        user_path = admins_path
      elsif rtype == 'Employer'
        user_path = edit_employer_path(rid)
      elsif rtype == 'member'
        user_path = edit_member_path(rid)
      end
      redirect_to user_path, :notice => "Password has been reset!"
    else
      #Rails.logger.info(@user.errors.messages.inspect)
      render 'edit'
    end
  end

  private
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