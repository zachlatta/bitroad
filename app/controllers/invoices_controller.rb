class InvoicesController < ApplicationController
  def show
    @invoice = Invoice.friendly.find(params[:id])
    if !@invoice.completed
      @invoice.update_attributes!(completed: true)
    elsif @invoice.session_id != request.session_options[:id]
      redirect_to root_path
    end
  end
end
