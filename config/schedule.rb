set :environment, :development
set :job_template, ":job"

every 1.minutes do
  rake "currencies:update_dollar_rate", :output => {:error => 'error.log', :standard => 'cron.log'}
end
