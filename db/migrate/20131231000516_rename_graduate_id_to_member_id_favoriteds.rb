class RenameMemberIdToMemberIdFavoriteds < ActiveRecord::Migration
  def change
  	rename_column :favoriteds, :member_id, :member_id
  end
end
