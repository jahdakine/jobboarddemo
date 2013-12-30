class CreateFavoriteds < ActiveRecord::Migration
  def change
    create_table :favoriteds do |t|
      t.integer :nonprofit_id
      t.integer :graduate_id

      t.timestamps
    end
  end
end
