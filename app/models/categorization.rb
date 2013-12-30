# == Schema Information
#
# Table name: categorizations
#
#  id          :integer          not null, primary key
#  interest_id :integer
#  opening_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Categorization < ActiveRecord::Base
  belongs_to :opening
  belongs_to :interest, :counter_cache => :openings_count
end