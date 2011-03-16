class ShippingAddress < ActiveRecord::Base

  belongs_to :user

  validates :street, :city, :zip, :state, :user, :presence => true
  validates :country, :length => {:is => 2}

  before_validation :set_country_default

  scope :us, where(:country => "US")

  private

  def set_country_default
    self.country = 'US' if self.country.blank?
  end

end
