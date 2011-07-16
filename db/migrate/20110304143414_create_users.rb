class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login_name   ,:string  ,:null => false ,:limit => 16
      t.column :admin_flag   ,:boolean ,:null => false ,:default => false
      t.timestamps
    end
    add_index :users ,[:login_name] ,:unique => true
  end

  def self.down
    drop_table :users
  end
end
