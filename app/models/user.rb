class User < ActiveRecord::Base

  devise :omniauthable, :registerable

  validates :first_name, :last_name, :presence => true
  validates :email, :email => {:message => "is not a valid email address"}, :presence => true, :uniqueness => true
  validates :uid, :presence => true, :if => Proc.new {|u| u.provider.present? }
  attr_accessible :first_name, :middle_name, :last_name, :email, :shipping_addresses_attributes, :provider, :uid, :username, :avatar

  has_many :shipping_addresses, :dependent => :destroy

  accepts_nested_attributes_for :shipping_addresses, :reject_if => :all_blank, :allow_destroy => true

  scope :with_twitter_uid, lambda {|uid| where(:uid => uid)}

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

  def self.new_with_session(params,session)
    super.tap do |user|
      uid = session['devise.twitter_uid']
      user_info = session['devise.twitter_user_info']
      if uid.present? && user_info.present?
        user.uid = uid
        user.username = user_info['nickname']
        user.avatar = user_info['image']
      end
    end
  end

end
