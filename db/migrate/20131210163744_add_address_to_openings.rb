class AddAddressToOpenings < ActiveRecord::Migration
  def change
    add_column :openings, :city, :string, limit: 30
    add_column :openings, :state, :string, limit: 30
    add_column :openings, :zip_code, :string, limit: 10  	
  end
end
