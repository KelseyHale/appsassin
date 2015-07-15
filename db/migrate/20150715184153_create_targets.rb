class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.boolean :active, default: true
    end
  end
end
