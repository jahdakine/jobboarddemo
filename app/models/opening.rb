# == Schema Information
#
# Table name: openings
#
#  id           :integer          not null, primary key
#  employer_id :integer
#  position     :string(255)
#  description  :text
#  active       :boolean
#  date_open    :date
#  date_closed  :date
#  created_at   :datetime
#  updated_at   :datetime
#  views_count  :integer          default(0)
#  city         :string(30)
#  state        :string(30)
#  zip_code     :string(10)
#
class Opening < ActiveRecord::Base
  belongs_to :employer, :counter_cache => :openings_count
  #interests-openings join (categorization)
  has_many :categorizations
  has_many :interests, :through => :categorizations
  #openings-members join (applications)
  has_many :applications
  has_many :members, :through => :applications

  delegate :company, :id, :to => :employer, :prefix => true

  validates_presence_of :position
  validates :city, :presence => true, :length => { :maximum => 30 }
  validates :state, :presence => true, :length => { :maximum => 30 }
  validates :zip_code, :presence => true, :length => { :maximum => 10 }
  #TODO: BUG: date_open says blank if less than today
  validates_presence_of :date_open
  validates_presence_of :description

  #deletes all openings past closed date -
  #scheduled task, but can be run manually
  def self.remove_stale_openings
    timespan = Time.zone.now
    stale_opening_array = Opening.find(
      :all,
      :select=>"openings.id",
      :conditions => "date_closed < '#{timespan}'"
    )
    Opening.delete_all(:id => stale_opening_array)
  end
end