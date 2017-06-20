require "./lib/app"
require "./lib/restarter"

# Start restarting builds
Restarter.restart

Rack::Handler.default.run Application.new, Port: ENV["PORT"]
