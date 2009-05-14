class CreateMibObjects < ActiveRecord::Migration
  def self.up
    create_table :mib_objects do |t|
      t.string :name
      t.string :oid

      t.timestamps
    end
  end

  def self.down
    drop_table :mib_objects
  end
end
