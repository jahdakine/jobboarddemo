#All role determination methods here
module Roles
  extend ActiveSupport::Concern

  included do
    ### class level code - before_filter ...
    #If the user is not a Grad, insuficient privs
    def is_graduate
      if !current_role(Graduate)
        print "\n\nNot Graduate\n\n"
        redirect_to logout_path, :alert => "Insufficient priviledges!"
      end
    end
    #If the user is not an NP, insuficient privs
    def is_nonprofit
      if !current_role(Nonprofit)
        print "\n\nNot NP\n\n"
        redirect_to logout_path, :alert => "Insufficient priviledges!"
      end
    end
    #If the user is not an Admin, insuficient privs
    def is_admin
      if !current_role(Admin)
        print "\n\nNot Admin\n\n"
        redirect_to logout_path, :alert => "Insufficient priviledges!"
      end
    end
    #If the user is not an Admin, or an NP, insuficient privs
    def is_admin_or_np
      if current_role(Graduate)
        print "\n\nNot NP or Admin\n\n"
        redirect_to logout_path, :alert => "Insufficient priviledges!"
      end
    end
  end

  ### instance methods here
  #Redirect login based on roles
  def role_router
    force = @user.force_reset
    reset = @user.password_reset_token
    rid = @user.role_id
    if current_role(Graduate)
      graduate = Graduate.find(rid)
      if graduate.skip
        redirect_to openings_path,
          :notice => "Log in successful"
      else
        redirect_to edit_graduate_path(graduate),
          :notice => "Log in successful"
      end
    elsif current_role(Nonprofit)
      if force
        redirect_to edit_password_reset_path(reset),
          alert: 'Please reset your temporary password'
      else
        nonprofit = Nonprofit.find(rid)
        if nonprofit.skip
          redirect_to openings_path, :notice => "Log in successful"
        else
          redirect_to edit_nonprofit_path(nonprofit),
            :notice => "Log in successful"
        end
      end
    elsif current_role(Admin)
      if force
        redirect_to edit_password_reset_path(reset),
          alert: 'Please reset your temporary password'
      else
        redirect_to admins_path, :notice => "Log in successful"
      end
    end
  end
end