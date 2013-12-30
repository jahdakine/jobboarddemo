class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :graduate_id
      t.integer :opening_id

      t.timestamps
    end
  end
end
