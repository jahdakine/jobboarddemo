class AddAddressesToNonprofits < ActiveRecord::Migration
  def change
    add_column :nonprofits, :city, :string, limit: 30
    add_column :nonprofits, :state, :string, limit: 30
    add_column :nonprofits, :zip_code, :string, limit: 10
  end
end
