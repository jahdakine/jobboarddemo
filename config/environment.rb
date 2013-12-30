# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Pbc::Application.initialize!

#auto-load hirb
if defined?(Rails::Console)
  require 'hirb'
  Hirb.enable
end