class RenameMemberIdToMemberIdInteresteds < ActiveRecord::Migration
  def change
  	rename_column :interesteds, :member_id, :member_id
  end
end
