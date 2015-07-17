class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :name, null: false
      t.belongs_to :game, null: false
    end
  end
end
