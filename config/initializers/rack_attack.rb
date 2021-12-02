module Rack
  class Attack
    ### Configure Cache ###

    # If you don't want to use Rails.cache (Rack::Attack's default), then
    # configure it here.
    #
    # Note: The store is only used for throttling (not blocklisting and
    # safelisting). It must implement .increment and .write like
    # ActiveSupport::Cache::Store

    # Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

    ### Throttle Spammy Clients ###

    # If any single client IP is making tons of requests, then they're
    # probably malicious or a poorly-configured scraper. Either way, they
    # don't deserve to hog all of the app server's CPU. Cut them off!
    #
    # Note: If you're serving assets through rack, those requests may be
    # counted by rack-attack and this throttle may be activated too
    # quickly. If so, enable the condition to exclude them from tracking.

    # Throttle all requests by IP (60rpm)
    #
    # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
    # throttle('req/ip/seconds', limit: 10,    period: 10.seconds, &:ip)
    # throttle('req/ip/minutes', limit: 100,   period: 3.minutes, &:ip)
    # throttle('req/ip/hours',   limit: 1000,  period: 1.hour, &:ip)
    # throttle('req/ip/days',    limit: 10000, period: 1.day, &:ip)

    ### Prevent Brute-Force Login Attacks ###

    # The most common brute-force login attack is a brute-force password
    # attack where an attacker simply tries a large number of emails and
    # passwords to see if any credentials match.
    #
    # Another common method of attack is to use a swarm of computers with
    # different IPs to try brute-forcing a password for a specific account.

    # Throttle POST requests to /login by IP address
    #
    # Key: "rack::attack:#{Time.now.to_i/:period}:logins/ip:#{req.ip}"
    throttle('logins/ip/seconds', limit: 5, period: 10.seconds) do |req|
      req.ip  if req.path.include?('/searches/') || req.path.include?('/cv/') || req.base_url + "/" == req.url
    end
    throttle('logins/ip/minutes', limit: 20, period: 10.minutes) do |req|
      req.ip  if req.path.include?('/searches/') || req.path.include?('/cv/') || req.base_url + "/" == req.url
    end
    throttle('logins/ip/hours', limit: 50, period: 10.hours) do |req|
      req.ip  if req.path.include?('/searches/') || req.path.include?('/cv/') || req.base_url + "/" == req.url
    end
    throttle('logins/ip/days', limit: 100, period: 10.days) do |req|
      req.ip  if req.path.include?('/searches/') || req.path.include?('/cv/') || req.base_url + "/" == req.url
    end

    # Throttle POST requests to /login by email param
    # (Not needed because we use the lockable module by Devise)
    # Key: "rack::attack:#{Time.now.to_i/:period}:logins/email:#{req.email}"
    #
    # Note: This creates a problem where a malicious user could intentionally
    # throttle logins for another user and force their login requests to be
    # denied, but that's not very common and shouldn't happen to you. (Knock
    # on wood!)
    # throttle("logins/email", limit: 5, period: 60.seconds) do |req|
    #   if req.path == '/admins/admins/sign_in' && req.post?
    #     # return the email if present, nil otherwise
    #     req.params['email'].presence
    #   end
    # end

    ### Custom Throttle Response ###

    # By default, Rack::Attack returns an HTTP 429 for throttled responses,
    # which is just fine.
    #
    # If you want to return 503 so that the attacker might be fooled into
    # believing that they've successfully broken your app (or you just want to
    # customize the response), then uncomment these lines.
    self.throttled_response = lambda do |env|
     [ 503,  # status
       {},   # headers
       []] # body
    end
  end
end
