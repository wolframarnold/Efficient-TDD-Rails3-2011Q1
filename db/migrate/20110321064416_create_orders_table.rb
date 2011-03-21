class CreateOrdersTable < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.belongs_to :shipping_address, :null => false
      t.timestamps
    end

    add_index :orders, :created_at
    add_index :orders, :shipping_address_id
  end

  def self.down
    drop_table :orders
  end
end
