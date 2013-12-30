# == Schema Information
#
# Table name: interests
#
#  id              :integer          not null, primary key
#  name            :string(35)
#  created_at      :datetime
#  updated_at      :datetime
#  openings_count  :integer          default(0)
#  graduates_count :integer          default(0)
#

class Interest < ActiveRecord::Base
  #graduates-interests join (interested)
  has_many :interesteds, dependent: :destroy
  has_many :graduates, :through => :interesteds, :counter_cache => true
  #interests-openings join (categorization)
  has_many :categorizations, dependent: :destroy
  has_many :openings, :through => :categorizations, :counter_cache => true

  validates :name,
    :presence => true,
    :uniqueness => true,
    :length => { :maximum => 35 }
end