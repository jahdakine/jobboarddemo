# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(100)
#  password_digest        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  role_type              :string(20)       default("Member"), not null
#  role_id                :integer          not null
#  force_reset            :boolean          default(FALSE)
#
#
class User < ActiveRecord::Base
  has_secure_password(validations: false) #explicit is clearer

  before_create { generate_token(:auth_token) }
  before_save { self.email = email.downcase }

  #Flags and params
  attr_accessor :skip_password,
  :check_password,
  :old_password,
  :current_password

  belongs_to :role, :polymorphic => true

  validates :agreement, acceptance: true, :on => :create
  validates :email,
    :presence => true,
    :uniqueness => true,
    case_sensitive: false,
    :on => :create
  validates :password,
    :confirmation => true,
    :format => {
      :with => PASSWORD_REGEX,
      message:
"must be between 6 and 20 characters of mixed case and contain at least one
number and one special character."
    },
    :unless => :skip_password
  validate :compare_password, :if => :check_password

  def compare_password
    # print "\n\n"
    # print self.old_password
    # print "\n\n"
    # print self.current_password
    # print "\n\n"
    # print BCrypt::Password.new(self.current_password)
    # print "\n\n"
    # print BCrypt::Password.new(self.current_password).is_password?
    # print self.old_password
    # print "\n\n"
    if self.old_password.empty?
      errors.add(:old_password, "can't be blank.")
    else
      match = BCrypt::Password.new(self.current_password).is_password?
        self.old_password
      # print "\n\nmatch\n\n"
      if !match
        errors.add(:old_password,
          " (#{self.old_password}) doesn't match the password on file.")
      end
    end
  end

  #NP was invited
  def send_registration_welcome
    UserMailer.registration_welcome(self).deliver
  end

  #User requested a reset
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    #Dont do password check - only email supplied
    self.skip_password = true
    save!
    UserMailer.password_reset(self).deliver
  end

  #Replace param password and pc with temp random,
  #save to db and send to prospective NP
  def send_invitation_welcome
    @temp = SecureRandom.urlsafe_base64(6) + "$"
    self.update_attributes(:password => @temp, :password_confirmation => @temp)
    save!
    UserMailer.invitation_welcome(self, @temp).deliver
  end

  #Random string generator for attributes
  def generate_token(column, length=30)
    begin
      self[column] = SecureRandom.urlsafe_base64(length)
    end while User.exists?(column => self[column])
  end

  def self.remove_stale_registrations
    timespan = Time.zone.now - 1.minute
    stale_user_array = User.find(
      :all,
      :select=>"users.id",
      :joins=>"JOIN members ON users.role_id = members.id",
      :conditions =>
        "members.first_name is NULL AND users.created_at < '#{timespan}'"
    )
    User.delete_all(:id => stale_user_array)
  end
end