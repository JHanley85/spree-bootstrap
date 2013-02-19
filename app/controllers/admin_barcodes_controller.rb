module Spree
  module Admin
    class BarcodesController < ApplicationController
      require 'g-data'
      require 'uri'
      #before_filter :check_for_mobile, :only => [:new, :edit]

      # GET /Barcodes
      # GET /Barcodes.json
      def index
        @barcodes = Barcode.all

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @barcodes }
        end
      end

      def attach_image
        data=GData::Local.new(params[:location], URI.unescape(params[:id]))
        respond_to do |format|
          format.json { render json: data }
        end
      end

      # GET /Barcodes/1
      # GET /Barcodes/1.json
      def show
        @barcode = Barcode.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @barcode }
        end
      end

      # GET /Barcodes/new
      # GET /Barcodes/new.json
      def get_data
        @barcode=params[:upc]
        if !params[:token]
          token=current_user.spree_api_key
        else
          token=params[:token]
        end
        @data=GData.new().google_store(params[:upc])

        #@data=GData::UPCDB.new(params[:upc])


        respond_to do |format|
          format.html
          format.json { render json: @data }

        end
      end

      def new
        @barcode = Barcode.new

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @barcode }
        end
      end

      # GET /Barcodes/1/edit
      def edit
        @barcode = Barcode.find(params[:id])
      end

      # POST /Barcodes
      # POST /Barcodes.json
      def create
        @barcode = Barcode.new(params[:upc])

        respond_to do |format|
          if @barcode.save
            format.html { redirect_to @barcode, notice: 'Upc was successfully created.' }
            format.json { render json: @barcode, status: :created, location: @barcode }
          else
            format.html { render action: "new" }
            format.json { render json: @Barcodes.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /Barcodes/1
      # PUT /Barcodes/1.json
      def update
        @barcode = Barcode.find(params[:id])

        respond_to do |format|
          if @barcode.update_attributes(params[:upc])
            format.html { redirect_to @barcode, notice: 'Upc was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @barcode.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /Barcodes/1
      # DELETE /Barcodes/1.json
      def destroy
        @barcode = Barcode.find(params[:id])
        @barcodes.destroy

        respond_to do |format|
          format.html { redirect_to admin_barcodes_url }
          format.json { head :no_content }
        end
      end
    end
  end
end