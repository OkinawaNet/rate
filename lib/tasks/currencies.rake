namespace :currencies do
  desc "TODO"
  task update_dollar_rate: :environment do
    rate = DollarRate.first_or_create
    rate.update_from_site

    ActionCable.server.broadcast 'rate_refresher_channel', rate.current_value
  end

end
