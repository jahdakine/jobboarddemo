# == Schema Information
#
# Table name: applications
#
#  id          :integer          not null, primary key
#  graduate_id :integer
#  opening_id  :integer
#  notes			 :text
#  created_at  :datetime
#  updated_at  :datetime
#
class Application < ActiveRecord::Base
  belongs_to :opening
  belongs_to :graduate
end