class RemoveMibsFromAgent < ActiveRecord::Migration
  def self.up
  	remove_column :agents, :mibs
  end

  def self.down
  	add_column :agents, :mibs, :text
  end
end
