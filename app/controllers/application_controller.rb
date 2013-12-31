#Globally available controller and view methods
class ApplicationController < ActionController::Base
  ### Prevent CSRF attacks by raising an exception.
  ### For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  private
    def authenticate
      redirect_to login_url,
      alert: "Not authorized or session timed out" if !current_user
    end
    def current_user
      token = cookies[:auth_token]
      @current_user ||=
        User.all.includes(:role => :user)
        .find_by_auth_token!(token) if token rescue return
    end
    helper_method :current_user
    def current_role(role)
      @current_role =
        current_user.role.is_a? (role) rescue redirect_to logout_url
    end
    helper_method :current_role
    def display_current_email
      @display_current_email ||= current_user.email rescue ""
    end
    helper_method :display_current_email
    def display_current_role
      @display_current_role ||= current_user.role_type rescue ""
    end
    helper_method :display_current_role
    def display_current_name
      cur_user = current_user.role
      if current_role(Member)
        @display_current_name =
          cur_user.first_name + " " + cur_user.last_name rescue ""
      elsif current_role(Employer)
        @display_current_name = cur_user.company rescue ""
      else
        @display_current_name = @display_current_email
      end
    end
    helper_method :display_current_name
    def referrer(type='')
      Rails.application.routes.recognize_path(request.referrer)
      [(type == "controller" ? :controller : :action)]
    end
    helper_method :referrer
    def back_search_w_params(path)
      session[:last_search] = url_for(params) || path
    end
    helper_method :back_search_w_params
  #end private
end