require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class SelogerApiService
  def call
    @properties = []
    set_url
    display_properties
  end

  def set_url
    (1..10).each do |page|
      url = URI("https://seloger.p.rapidapi.com/properties/list?zipCodes=69006&pageIndex=#{page}&pageSize=50&realtyTypes=1&transactionType=1&sortBy=0&includeNewConstructions=true")
      get_properties(url)
    end
  end

  def get_properties(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = ENV['SELOGER_API_KEY']
    request["X-RapidAPI-Host"] = 'seloger.p.rapidapi.com'

    @response = http.request(request)
    @properties << JSON.parse(@response.read_body)
  end

  def display_properties
    ap @properties.flatten.count
    ap @properties.flatten
  end
end
