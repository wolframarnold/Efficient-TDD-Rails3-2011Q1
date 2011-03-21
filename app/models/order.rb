class Order < ActiveRecord::Base

  validates :shipping_address, :presence => true

  belongs_to :shipping_address
end
