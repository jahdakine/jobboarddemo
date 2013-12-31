class RenameNonprofitsToEmployers < ActiveRecord::Migration
  def change
  	rename_table :nonprofits, :employers
  end
end
