class ShippingAddress < ActiveRecord::Base

  belongs_to :user

  validates :street, :city, :zip, :state, :user, :presence => true
  validates :country, :length => {:is => 2}

  before_validation :set_country_default

  has_many :orders

  scope :us, where(:country => "US")
  scope :in_state, lambda {|st| where(:state => st) }

  # Note: the lambda here is important, to force re-evaluation of Time.now ever time the query is run. Otherwise it would only
  # get the current time once, at load time of the class which, in production mode, could have been quite some time ago...
  # Alternatively, we can ask the database for its current time, using SQL's NOW() function.
  scope :on_file, lambda { includes(:orders).order('orders.created_at DESC').where('orders.created_at > ?', 12.months.ago) }

  private

  def set_country_default
    self.country = 'US' if self.country.blank?
  end

end
