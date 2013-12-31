# == Schema Information
#
# Table name: favoriteds
#
#  id           :integer          not null, primary key
#  employer_id :integer
#  member_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Favorited < ActiveRecord::Base
  belongs_to :member
end