class User < ActiveRecord::Base

  validates :first_name, :last_name, :presence => true
  validates :email, :email => {:message => "is not a valid email address"}, :allow_blank => true

  attr_accessible :first_name, :middle_name, :last_name, :email, :shipping_addresses_attributes

  has_many :shipping_addresses, :dependent => :destroy

  accepts_nested_attributes_for :shipping_addresses, :reject_if => :all_blank, :allow_destroy => true

  def full_name
    name = first_name
    name << (' ' + middle_name) unless middle_name.blank?
    name << ' '
    name << last_name
    name
  end

  def as_json(opts={})
    users_hash  = super
    users_hash['user'].except!(*%w(id admin))
    users_hash
  end

end
