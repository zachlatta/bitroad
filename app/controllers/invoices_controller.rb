require "coinbase"

class InvoicesController < ApplicationController
  def show
    @invoice = Invoice.friendly.find(params[:id])
    if !@invoice.completed
      coinbase = Coinbase::Client.new(Figaro.env.coinbase_secret)
      coinbase.send_money @invoice.listing.bitcoin_address, @invoice.listing.price * 0.9
      @invoice.update_attributes!(completed: true)
    elsif @invoice.session_id != request.session_options[:id]
      redirect_to root_path
    end
  end
end
