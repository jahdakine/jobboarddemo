#Helper functions specific to the opening actions
module OpeningsHelper
  def set_path(opening)
    if current_role(Admin)
      @return_path = employer_path(opening.employer_id)
      @user_id = opening.employer_id
    else
      @return_path = "/openings"
      @user_id = current_user.role_id
    end
  end
end