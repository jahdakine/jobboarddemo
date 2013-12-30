class AddNotesToApplications < ActiveRecord::Migration
  def change
  	add_column :applications, :notes, :text, limit: 500
  end
end
