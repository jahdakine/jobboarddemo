# == Schema Information
#
# Table name: graduates
#
#  id                   :integer          not null, primary key
#  first_name           :string(25)
#  last_name            :string(25)
#  address_1            :string(50)
#  address_2            :string(50)
#  city                 :string(30)
#  state                :string(30)
#  zip_code             :string(10)
#  phone                :string(25)
#  volunteer_experience :text
#  work_experience      :text
#  created_at           :datetime
#  updated_at           :datetime
#  skip                 :boolean          default(FALSE)
#

class Graduate < ActiveRecord::Base
  has_one :user, :as => :role, dependent: :destroy
  #graduates-interests join (interested)
  has_many :interesteds
  has_many :interests, :through => :interesteds
  #graduates-openings join (applications)
  has_many :applications
  has_many :openings, :through => :applications
  #graduates-nonprofits join (favoriteds)
  has_many :favoriteds
  has_many :nonprofits, :through => :favoriteds

  delegate :email, :created_at, :updated_at, :to => :user, :prefix => true

  #Only validate if not creating user
  validates :first_name,
    :presence => true,
    :length => { :maximum => 25 },
    :on => :update
  validates :last_name,
    :presence => true,
    :length => { :maximum => 25 },
    :on => :update
  validates :address_1,
    :length => { :maximum => 50 },
    :on => :update
  validates :address_2,
    :length => { :maximum => 50 },
    :on => :update
  validates :city,
    :length => { :maximum => 30 },
    :on => :update
  validates :state,
    :length => { :maximum => 30 },
    :on => :update
  validates :zip_code,
    :length => { :maximum => 10 },
    :on => :update
  #VALID_US_PHONE_REGEX=/\A\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\z/
  #validates_format_of :phone, :with => VALID_US_PHONE_REGEX, :on => :update
  validates :phone,
    :presence => true,
    :length => { :maximum => 25 },
    :on => :update
  validates :volunteer_experience,
    :presence => true,
    :length => {
      :maximum => 5000,
      :message => '
is too long (maximum is 5000 characters - includes HTML formatting characters)
'
    },
    :on => :update
  validates :work_experience,
    :presence => true,
    :length => {
      :maximum => 5000,
      :message => '
is too long (maximum is 5000 characters - includes HTML formatting characters)
'
    },
    :on => :update
end