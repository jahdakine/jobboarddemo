class RenameNonprofitIdToEmpoyerIdOpenings < ActiveRecord::Migration
  def change
  	rename_column :openings, :nonprofit_id, :employer_id
  end
end
