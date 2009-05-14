class CreateMibs < ActiveRecord::Migration
  def self.up
    create_table :mibs do |t|
      t.string :name
      t.string :oid
      t.string :module_location

      t.timestamps
    end
  end

  def self.down
    drop_table :mibs
  end
end
