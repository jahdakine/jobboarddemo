#Helper functions specific to the opening actions
module OpeningsHelper
  def set_path(opening)
    if current_role(Admin)
      @return_path = nonprofit_path(opening.nonprofit_id)
      @user_id = opening.nonprofit_id
    else
      @return_path = "/openings"
      @user_id = current_user.role_id
    end
  end
end