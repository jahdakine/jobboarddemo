#Helper functions specific to the user actions
module UsersHelper
  def setup_users(user)
    @admin = ''
    if user.role_type == 'Graduate'
      @blank = user.role.first_name.blank?
      @extra = ''
    elsif user.role_type == 'Nonprofit'
      @blank = user.role.company.blank?
      @extra = 'Continuing will remove all associated openings. '
    elsif user.role_type == 'Admin'
      @admin = "Administrator"
    end
    if user.created_at < Time.now - 3.months
      @mark = 'red'
    else
      @mark = 'lightred'
    end
  end
end