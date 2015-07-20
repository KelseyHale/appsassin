class AddLimitToGames < ActiveRecord::Migration
  def change
    add_column :games, :limit, :integer, null: false
  end
end
