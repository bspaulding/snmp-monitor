class CreateAgents < ActiveRecord::Migration
  def self.up
    create_table :agents do |t|
      t.string :ip_address
      t.text :mibs

      t.timestamps
    end
  end

  def self.down
    drop_table :agents
  end
end
