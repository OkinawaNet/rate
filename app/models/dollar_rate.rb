require "./lib/currency_rates.rb"
include ActionView::Helpers::NumberHelper

class DollarRate < ApplicationRecord
  validates :value,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
            },
            allow_nil: true
  validates :forced_value,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
            },
            allow_nil: true
  validates :forced_until,
            date: {
                after: Proc.new {Time.now}, message: :cannot_be_in_the_past,
            },
            allow_nil: true

  def update_from_site
    dollar_rate = CurrencyRates.get_dollar_rate

    if dollar_rate
      rate_params = {:value => format_price_to_db(dollar_rate)}
      self.update_attributes(rate_params)
    end
  end


  def current_value
      if self.forced_value && self.forced_until && Time.new <= self.forced_until
        format_price_from_db(self.forced_value)
      else
        format_price_from_db(self.value)
      end
  end

  def formatted_forced_value=(value)
    self.forced_value = format_price_to_db(value)
  end

  def formatted_forced_value
    format_price_from_db(self.forced_value)
  end

    private
  def format_price_to_db(value)
    (value.to_f.round(2) * 100).to_i
  end

  def format_price_from_db(value)
    number_with_precision((value.to_f / 100), precision: 2)
  end

end
