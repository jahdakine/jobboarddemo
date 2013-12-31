class RenameMembersCountToMembersCountInterests < ActiveRecord::Migration
  def change
  	rename_column :interests, :members_count, :members_count
  end
end
