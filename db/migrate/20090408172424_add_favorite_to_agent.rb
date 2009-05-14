class AddFavoriteToAgent < ActiveRecord::Migration
  def self.up
    add_column :agents, :favorite, :boolean
  end

  def self.down
    remove_column :agents, :favorite
  end
end
