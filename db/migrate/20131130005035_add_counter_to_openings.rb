class AddCounterToOpenings < ActiveRecord::Migration
  def change
  	add_column :openings, :views_count, :integer, :default => 0
  end
end

#Opening.increment_counter :views_count