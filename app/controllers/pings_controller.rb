require "domain_ping"
# Location in lib/domain_ping.rb

class PingsController < ApplicationController
  def create
    @domain = Domain.find(params[:domain_id])
    @ping = DomainPing.call(@domain)
  end
end
