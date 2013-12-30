# == Schema Information
#
# Table name: openings
#
#  id           :integer          not null, primary key
#  nonprofit_id :integer
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

require 'spec_helper'

describe Opening do
  pending "add some examples to (or delete) #{__FILE__}"
end
