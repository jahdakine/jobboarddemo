class RenameNonprofitIdToEmpoyerId < ActiveRecord::Migration
  def change
  	rename_column :favoriteds, :nonprofit_id, :employer_id
  end
end
