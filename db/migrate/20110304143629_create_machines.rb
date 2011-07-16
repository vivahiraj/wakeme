class CreateMachines < ActiveRecord::Migration
  def self.up
    create_table :machines do |t|
      t.column :user_id   ,:integer  ,:null => false
      t.column :name      ,:string   ,:null => false ,:limit => 16
      t.column :ip        ,:string   ,:null => false ,:limit => 15
      t.column :mask      ,:string   ,:null => false ,:limit => 15
      t.column :bcast     ,:string   ,:null => false ,:limit => 15
      t.column :mac       ,:string   ,:null => false ,:limit => 17
      t.timestamps
    end
    add_index :machines ,[:user_id,:ip] ,:unique => true
  end

  def self.down
    drop_table :machines
  end
end
