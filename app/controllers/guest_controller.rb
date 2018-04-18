class GuestController < ApplicationController
  def index
    @rate = DollarRate.first_or_create
  end
end
