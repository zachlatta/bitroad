require 'bitpay'

class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    @listing.price = @listing.price / 1000 # because the price is in mBTC. TODO: make this not an ugly hack

    if @listing.save
      redirect_to @listing
    else
      render "new"
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def purchase
    @listing = Listing.find(params[:id])
    client = BitPay::Client.new "FpLmgO5JoKRTzGtbkry46txLzNE3F1V0LW04CwgqUM"
    invoice = client.post 'invoice', { price: @listing.price, currency: 'BTC', redirectURL: "http://#{root_path}#{@listing.file.url}" }
    if invoice
      redirect_to invoice["url"]
    else
      redirect_to root_path
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :file, :price, :bitcoin_address)
  end
end
