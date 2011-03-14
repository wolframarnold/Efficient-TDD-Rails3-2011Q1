class User < ActiveRecord::Base

  validates :first_name, :last_name, :presence => true
  validates :email, :email => {:message => "is not a valid email address"}, :allow_blank => true

  attr_accessible :first_name, :middle_name, :last_name, :email

  has_many :shipping_addresses, :dependent => :destroy

  def full_name
    name = first_name
    name << (' ' + middle_name) unless middle_name.blank?
    name << ' '
    name << last_name
    name
  end
  
end
