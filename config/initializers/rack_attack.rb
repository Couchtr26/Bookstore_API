class Rack::Attack
  throttle("api/requests", limit: 100, period: 3600) do |req|
    req.ip if req.path.start_with?("/api/v1/books")
  end

  # Blocklist IPs that are making too many requests
  blocklist("block abusive IPs") do |req|
    Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 100, findtime: 1.hour, bantime: 1.day) do
      req.path.start_with?("/api/v1/books") && req.get?
    end
  end
end
