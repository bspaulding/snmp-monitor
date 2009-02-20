class AddCommunityToAgent < ActiveRecord::Migration
  def self.up
    add_column :agents, :community, :string
  end

  def self.down
    remove_column :agents, :community
  end
end
