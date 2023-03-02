require "domain_ping"
# Location in lib/domain_ping.rb


class MonitorJob < ApplicationJob
  queue_as :default

  def perform(domain)
    return if domain.monitoring == false

    DomainPing.call(domain)
    MonitorJob.set(wait_until: 2.seconds.from_now).perform_later(domain)
  end
end
