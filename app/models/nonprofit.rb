# == Schema Information
#
# Table name: nonprofits
#
#  id             :integer          not null, primary key
#  company        :string(50)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  skip           :boolean          default(FALSE)
#  openings_count :integer          default(0)
#  city           :string(30)
#  state          :string(30)
#  zip_code       :string(10)
#

class Nonprofit < ActiveRecord::Base
  has_one :user, :as => :role, dependent: :destroy
  has_many :openings, dependent: :destroy
  #graduates-nonprofits join (favoriteds)
  has_many :favoriteds
  has_many :graduates, :through => :favoriteds

  delegate :email, :created_at, :updated_at, :to => :user, :prefix => true

  #Only validate if not creating user
  validates :company,
    :presence => true,
    :length => { :maximum => 50 },
    :on => :update
  validates :city,
    :presence => true,
    :length => { :maximum => 30 },
    :on => :update
  validates :state,
    :presence => true,
    :length => { :maximum => 30 },
    :on => :update
  validates :zip_code,
    :presence => true,
    :length => { :maximum => 10 },
    :on => :update
  validates :description,
    :presence => true,
    :length => {
      :maximum => 5000,
      :message => '
is too long (maximum is 5000 characters - includes HTML formatting characters)
'
    },
    :on => :update
end