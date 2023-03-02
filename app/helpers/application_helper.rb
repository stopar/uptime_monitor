module ApplicationHelper
  def ping_status(ping)
    return "table-warning" if ping.nil?
    return "table-success" if ping.alive?

    "table-danger"
  end

  def ping_date(ping)
    return "-" if ping.nil?

    ping.created_at.to_fs(:ping_time)
  end

  def ping_response(ping)
    return "-" if ping.nil?

    ping.response_time
  end

  def ping_alive(ping)
    return "-" if ping.nil?

    ping.alive
  end
end
