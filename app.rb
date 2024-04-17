require "sinatra"
require "sinatra/reloader"
require "json"
require "http"

api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

# before do
#   @data_raw = HTTP.get(api_url)
#   @data = JSON.parse(@data_raw)
#   @currencies = @data.fetch("currencies")
#   @keys = @currencies.keys
# end

get("/") do
  @data_raw = HTTP.get(api_url)
  @data = JSON.parse(@data_raw)
  @currencies = @data.fetch("currencies")
  @keys = @currencies.keys
  erb(:homepage)
end

get("/:from_currency") do
  @data_raw = HTTP.get(api_url)
  @data = JSON.parse(@data_raw)
  @currencies = @data.fetch("currencies")
  @keys = @currencies.keys
  @original_currency = params.fetch("from_currency")

  erb(:convert)
end

get("/:from_currency/:to_currency") do
  @data_raw = HTTP.get(api_url)
  @data = JSON.parse(@data_raw)
  @currencies = @data.fetch("currencies")
  @keys = @currencies.keys
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")
  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  @raw_data = HTTP.get(@api_url)
  @parsed_data = JSON.parse(@raw_data)

  # @api_url_conversion = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  # @response = HTTP.get(@api_url_conversion)
  # @parsed_conversion = JSON.parse(@response.to_s)
  # @quote = @parsed_conversion.fetch("info").fetch("quote")

  erb(:results)
end
