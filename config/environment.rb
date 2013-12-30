# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
JobBoardDemo::Application.initialize!

#auto-load hirb
if defined?(Rails::Console)
  require 'hirb'
  Hirb.enable
end