require 'open-uri'
class Product

  BASE_URL = "http://www.amazon.com/rss/tag/running/popular?length=1"

  attr_accessor :title, :link, :image_url

  def initialize(hash={})
    @title = hash[:title]
    @link = hash[:link]
    @image_url = hash[:image_url]
  end

  def self.fetch_all
    SimpleRSS.parse(open(BASE_URL)).items.map do |i|
      Product.new(:title => i.title, :link => i.link, :image_url => parse_img_url(i.description))
    end
  end

  private

  def self.parse_img_url(desc)
    xml = Nokogiri::XML.parse(desc)
    xml.css("img").first['src']
  end

end
