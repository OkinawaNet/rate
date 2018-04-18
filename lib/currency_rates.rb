require 'open-uri'
require 'nokogiri'

class CurrencyRates
  def self.get_dollar_rate
    html = get_rate_page('http://www.banki.ru/products/currency/usd/')

    if html
      doc = Nokogiri::HTML(html)
      doc.at_css('.currency-table__rate .currency-table__large-text').text.strip.sub!(',', '.')
    end
  end

  def self.get_rate_page(url)
    open(url)
  rescue OpenURI::HTTPError => the_error
    Rails.logger.error "#{the_error.message}"
    nil
  end
end