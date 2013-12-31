# == Schema Information
#
# Table name: Interesteds
#
#  id          :integer          not null, primary key
#  interest_id :integer
#  member_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Interested < ActiveRecord::Base
  belongs_to :member
  belongs_to :interest, :counter_cache => :members_count
end