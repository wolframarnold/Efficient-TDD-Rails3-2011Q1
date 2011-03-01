class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration.new("Can't undo, sorry")
    #drop_table :users
  end
end
