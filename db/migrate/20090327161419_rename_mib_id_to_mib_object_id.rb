class RenameMibIdToMibObjectId < ActiveRecord::Migration
  def self.up
  	rename_column :data_records, :mib_id, :mib_object_id
  end

  def self.down
  	rename_column :data_records, :mib_object_id, :mib_id
  end
end
