class AddDefaultTableDisplayLengthToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :def_table_disp, :integer, :default => '10'
  end
end
