require "net/http"

INSTANCE_URL = ENV.fetch("INSTANCE_URL")
ACCESS_TOKEN = ENV.fetch("ACCESS_TOKEN")

class Client
  def verify_account
    url = URI("#{INSTANCE_URL}/api/v1/accounts/verify_credentials")
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{ACCESS_TOKEN}"

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == "https") do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      throw "Error: #{response.code} - #{response.message}"
    end
  end
end
