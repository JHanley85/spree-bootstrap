module Spree
  module Admin
    class StoreThemesController < Spree::Admin::BaseController
      def index
        @file=File.join(Rails.root, '/app/assets/stylesheets/bootstrap/_variables_less.scss')

        @file=File.join(File.dirname(__FILE__), "../../app/assets/stylesheets/bootstrap/_variables_less.scss") unless File.exists?(@file)
        @contents=File.open(@file, 'r+').read
      end

      def show
        @file=File.join(Rails.root, '/app/assets/stylesheets/bootstrap/_variables_less.scss')

        @file=File.join(File.dirname(__FILE__), "../../app/assets/stylesheets/bootstrap/_variables_less.scss") unless File.exists?(@file)
        @contents=File.open(@file, 'r+').read
      end

      def update
        @file=File.join(Rails.root, '/app/assets/stylesheets/bootstrap/_variables_less.scss')
        directory_name=File.join(Rails.root, '/app/assets/stylesheets/bootstrap/')
        Dir.mkdir(directory_name) unless File.exists?(directory_name)
        if params[:variables]
          @variables=params[:variables].gsub("@", "$").gsub('spin(', 'adjust-hue(').gsub('$import', '@import')
          file=File.open(@file, 'w') { |f| f.write(@variables) }
        end
        redirect_to :action => :index
      end
    end

  end
end
