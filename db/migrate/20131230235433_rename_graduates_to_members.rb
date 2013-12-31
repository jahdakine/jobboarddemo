class RenameMembersToMembers < ActiveRecord::Migration
  def change
  	rename_table :members, :members
  end
end
