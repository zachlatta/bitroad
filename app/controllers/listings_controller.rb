require 'bitpay'

class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

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
    client = BitPay::Client.new Figaro.env.bitpay_key
    invoice = @listing.invoices.create(file: @listing.file, session_id: request.session_options[:id])
    bp_invoice = client.post 'invoice', { price: @listing.price, currency: 'BTC', redirectURL: "#{root_url[0..-2]}#{invoice_path(invoice)}" }
    if invoice
      redirect_to bp_invoice["url"]
    else
      redirect_to root_path
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :file, :price, :bitcoin_address)
  end
end
