class CreateShippingAddresses < ActiveRecord::Migration
  def self.up
    create_table :shipping_addresses do |t|
      t.belongs_to :user, :null => false
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.string :country

      t.timestamps
    end

    add_index :shipping_addresses, :user_id
  end

  def self.down
    drop_table :shipping_addresses
  end
end
