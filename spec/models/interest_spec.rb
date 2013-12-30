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

require 'spec_helper'

describe Interest do
  pending "add some examples to (or delete) #{__FILE__}"
end
