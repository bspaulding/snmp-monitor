class CreateTraps < ActiveRecord::Migration
  def self.up
    create_table :traps do |t|
      t.string :uptime
      t.string :oid
      t.integer :agent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :traps
  end
end
