#!/usr/bin/env ruby

# Use the currently running Rails environment
ENV["RAILS_ENV"] ||= Rails.env

require File.dirname(__FILE__) + "/../../config/environment"

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  
  # Replace this with your code
  ActiveRecord::Base.logger.info "This daemon is still running at #{Time.now}.\n"
  
  sleep 10
end