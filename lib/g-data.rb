# This program takes a UPC, searches Google
# and if not found, then searchupc
# in the future other databases as well.
require 'httparty'
require 'uri'
class GData
  attr_accessor :gkey,
                :google_root,
                :searchupc_key,
                :searchupc_root,
                :upcdatabase_key,
                :upcdatabase_root

  #Must have API KEY and ROOT defined in
  # CONFIG/INITIALIZERS/SPREE.rb
  #Ex:
  # Spree.config do |config|
  #  config.site_name = "My Spree Site"
  #  config.google_analytics=''
  #  config.google_store_key="AIzaSyA.....Drzaqg1OHA"
  #  config.google_store_root="https://www.googleapis.com/shopping/search/v1/public/"
  def initialize
    @gkey =Spree::Config.google_store_key
    @google_root = Spree::Config.google_store_root
    @searchupc_key=Spree::Config.search_upc_key
    @searchupc_root=Spree::Config.search_upc_root
    @upcdatabase_key=Spree::Config.upcdatabase_key
    @upcdatabase_root=Spree::Config.upcdatabase_root
  end

  #Searches the google store and returns json
  #For More Info:
  # https://developers.google.com/commerce-search/docs/query#searchresults
  def google_store(query)
    search_string="products?key=#{@gkey}&country=US&crowdBy=gtin:1&q=#{query}"
    gs= HTTParty.get(@google_root+search_string)
    response=gs.parsed_response
    if response['items'].nil?
      self.search_upc(query)
    else
      data=gs.parsed_response['items'][0]
      return data
    end
  end
  #Searches UPC Database.com
  #Using the JSON API
  #Our JSON API service is located at the following URL:
  # http://www.upcdatabase.org/api/json/APIKEY/CODE
  #Output if the code exists:
  # {"valid":"true","number":"0111222333446","itemname":"UPC Database Testing Code","description":"http:\/\/upcdatabase.org\/code\/0111222333446","price":"123.45","ratingsup":"2","ratingsdown":"0"}
  #Output if the code does not exists:
  # {"valid":"false","reason":"Code not found in database."}

  def upcdatabase(query)
    search_string="#{@upcdatabase_key}/#{query}"
    su = HTTParty.get("#{@upcdatabase_root}#{search_string}")
    data=su.parsed_response
    return data
  end

  #Searches searchupc.com and returns
  #For More Info:
  # http://searchupc.com/api/
  def search_upc(query)
    search_string="#{@searchupc_key}&upc=#{query}"
    su= HTTParty.get(@searchupc_root+search_string)
    data=su.parsed_response
    return data
  end

  #class to attach image to product
  class GData::Local
    #Creation: Get web location of image
    #Create folder if none exists, (DEFINE IN SPREE SETTINGS AS temp_image_folder)
    #use Rails.root/tmp/images/ as default
    def initialize(web, pid)
      @product=Spree::Product.find(pid)
      if Spree::Config.temp_image_folder?
      unless File.directory?(Spree::Config.temp_image_folder)
        FileUtils.mkdir_p(Spree::Config.temp_image_folder)
      end
      else
        unless File.directory?("#{Rails.root}/tmp/images/")
          FileUtils.mkdir_p("#{Rails.root}/tmp/images/")
        end
      end

      resp = HTTParty.get(web)
      @filename=web.split("/").last
      file=File.open(@localdir+@filename, "wb") { |f| f.write(resp.body) }
      attach_file
    end
    #Attaches downloaded image to Product
    #Uses Spree's included Paperclip to attach
    def attach_file
      @product.images.create(:attachment => File.new(@localdir+@filename, "r"))
    end
  end
end