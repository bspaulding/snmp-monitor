class AddNameToAgent < ActiveRecord::Migration
  def self.up
    add_column :agents, :name, :string
  end

  def self.down
    remove_column :agents, :name
  end
end
