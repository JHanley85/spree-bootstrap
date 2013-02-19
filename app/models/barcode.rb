module Spree
  class Barcode < ActiveRecord::Base
    attr_accessible :code, :image, :raw
  end
end