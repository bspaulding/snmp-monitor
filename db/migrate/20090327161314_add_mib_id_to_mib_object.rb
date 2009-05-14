class AddMibIdToMibObject < ActiveRecord::Migration
  def self.up
    add_column :mib_objects, :mib_id, :integer
  end

  def self.down
    remove_column :mib_objects, :mib_id
  end
end
