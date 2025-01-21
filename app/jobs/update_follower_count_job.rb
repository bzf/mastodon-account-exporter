require "prometheus/client"

class UpdateFollowerCountJob < ApplicationJob
  LABELS = [ "username" ]
  FOLLOWERS_COUNT = Prometheus::Client.registry.gauge(
    :followers_count,
    docstring: "Number of followers for the account",
    labels: [ :username ]
  )

  def perform
    verify_account_response = Client.new.verify_account

    FOLLOWERS_COUNT.set(
      verify_account_response["followers_count"],
      labels: {
        username: verify_account_response["username"]
      }
    )
  end
end
