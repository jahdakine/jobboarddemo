class AddMissingIndexes < ActiveRecord::Migration
	def change
	  add_index :favoriteds, :graduate_id
	  add_index :favoriteds, [:graduate_id, :nonprofit_id]
	  add_index :interesteds, :graduate_id
	  add_index :interesteds, :interest_id
	  add_index :interesteds, [:graduate_id, :interest_id]
	  add_index :applications, :opening_id
	  add_index :applications, :graduate_id
	  add_index :categorizations, :opening_id
	  add_index :categorizations, :interest_id
	  add_index :categorizations, [:interest_id, :opening_id]
	end
end
