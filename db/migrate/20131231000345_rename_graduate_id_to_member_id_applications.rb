class RenameMemberIdToMemberIdApplications < ActiveRecord::Migration
  def change
  	rename_column :applications, :member_id, :member_id
  end
end
