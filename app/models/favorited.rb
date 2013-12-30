# == Schema Information
#
# Table name: favoriteds
#
#  id           :integer          not null, primary key
#  nonprofit_id :integer
#  graduate_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Favorited < ActiveRecord::Base
  belongs_to :graduate
end