require "rubygems"
require "bundler"
require_relative "../lib/restarter.rb"

Bundler.require(:test)

include Restarter

# Observe safety protocols while time travelling 🕚
Timecop.safe_mode = true
