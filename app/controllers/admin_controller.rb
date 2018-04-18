class AdminController < ApplicationController
  def index
    @rate = DollarRate.first_or_create
  end

  def rate_update
    rate = DollarRate.first_or_create

    rate.update_attributes(process_params(rate_params))

    ActionCable.server.broadcast 'rate_refresher_channel', rate.current_value

    redirect_to(:action => :index)
  end

  private
  def rate_params
    params.require(:rate).permit(:formatted_forced_value, :forced_until, :time_difference)
  end

  def process_params(params)
    rate_params = {}

    rate_params[:forced_until] = !(params[:forced_until].strip.empty?) ? (params[:forced_until].to_datetime.advance(:minutes => params[:time_difference].to_i)).utc : nil
    rate_params[:formatted_forced_value] = params[:formatted_forced_value]

    rate_params
  end
end
