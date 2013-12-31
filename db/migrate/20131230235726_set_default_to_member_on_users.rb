class SetDefaultToMemberOnUsers < ActiveRecord::Migration
  def change
  	change_column :users, :role_type, :string, :default => 'Member'
  end
end
