require "net/http"

class DomainPing

  def self.call(domain)
    http = Net::HTTP.new(domain.name, 80)

    start_time = Time.now
    response = http.request(Net::HTTP::Get.new("/"))
    response_time = (Time.now - start_time) * 1000

    domain.pings.create(response_time: response_time, alive: true)
    
  rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::EHOSTUNREACH,
    Errno::ECONNREFUSED, EOFError, Net::HTTPBadResponse,
    Net::HTTPHeaderSyntaxError, Net::ProtocolError, SocketError
    domain.pings.create(alive: false)
  end
end