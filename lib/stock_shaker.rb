# frozen_string_literal: true

require 'active_support/all'

require 'stock_shaker/lazada_open_platform'
require 'stock_shaker/shopee_open_platform'
require 'stock_shaker/utility'

require 'stock_shaker/version'

module StockShaker
  # See more: https://github.com/rubocop-hq/ruby-style-guide#module-function
  module_function

  # TODO: Delete this method before build gem
  def test_lazada
    url = LazadaOpenPlatform::API_GATEWAY_URL_TH
    app_key = ENV['APP_KEY']
    app_secret = ENV['APP_SECRET']
    access_token = ENV['APP_SECRET']

    client = LazadaOpenPlatform::Client.new(url, app_key, app_secret)
    request = LazadaOpenPlatform::Request.new('/orders/get', 'GET')
    request.add_api_params('update_after', Utility.datetime_to_iso8601_format(DateTime.now.beginning_of_day - 2.days).to_s)
    request.add_api_params('offset', '0')
    request.add_api_params('limit', '10')
    request.add_api_params('sort_direction', 'DESC')
    request.add_api_params('sort_by', 'updated_at')
    response = client.execute(request, access_token)
    puts response.success?
    puts response.body
  end
end
