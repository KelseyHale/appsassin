class CreateRoundAssignments < ActiveRecord::Migration
  def change
    create_table :round_assignments do |t|
      t.integer :round_id
      t.integer :player_id
      t.integer :target_id
    end
  end
end
