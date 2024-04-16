require "sinatra"
require "sinatra/reloader"
require "json"
require "http"

api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

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
