class AddProviderUidUsernameAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :username
      t.string :avatar
      t.index [:provider, :uid]
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :provider
      t.remove :uid
      t.remove :username
      t.remove :avatar
    end
  end
end
