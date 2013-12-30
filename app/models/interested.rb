# == Schema Information
#
# Table name: Interesteds
#
#  id          :integer          not null, primary key
#  interest_id :integer
#  graduate_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Interested < ActiveRecord::Base
  belongs_to :graduate
  belongs_to :interest, :counter_cache => :graduates_count
end