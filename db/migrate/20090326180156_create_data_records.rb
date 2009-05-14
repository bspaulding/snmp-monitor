class CreateDataRecords < ActiveRecord::Migration
  def self.up
    create_table :data_records do |t|
      t.integer :agent_id
      t.integer :mib_id

      t.timestamps
    end
  end

  def self.down
    drop_table :data_records
  end
end
