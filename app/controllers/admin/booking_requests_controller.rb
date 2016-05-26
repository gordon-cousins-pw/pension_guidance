class Admin::BookingRequestsController < ApplicationController
  layout 'full_width'

  def index
    @booking_requests = BookingRequest.where.not(first_name: nil).last(50).reverse
  end
end
