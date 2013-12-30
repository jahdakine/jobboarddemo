source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'sass-rails', '4.0.0'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
#For has_secure_password
gem 'bcrypt-ruby', '3.0.1'
#Allows auto-population of records with semi-meaningful content
gem 'faker', '1.1.2'
#Easy pagination
gem 'will_paginate', '3.0.4'

group :development, :test do
  #move out of group if deploying to PDMagic server
  gem 'mysql2'
  gem 'childprocess', '0.3.6'
  #Creates PDF of ERD from database schema
  gem "rails-erd"
    #https://github.com/voormedia/rails-erd
  #Gives better console table format
  gem 'hirb'
    #https://github.com/cldwalker/hirb
  #Nice error formatting
  gem 'better_errors'
    #https://github.com/charliesome/better_errors
  #Add-on for better_errors
  gem "binding_of_caller"
  #Adds extra documentation to models, test, routes, etc
  gem 'annotate'
    #https://github.com/ctran/annotate_models
  #Can help with poorly constructed queries
  gem 'bullet'
    #https://github.com/flyerhzm/bullet
  #Debugging
  gem 'debugger'
    #https://github.com/cldwalker/debugger
  #expose localhost to public
  #gem 'localtunnel'
    #https://github.com/progrium/localtunnel
  #Look for missing indexes
  gem 'lol_dba'
    #https://github.com/plentz/lol_dba
  #gem 'mailcatcher' installed thru shell
    #http://mailcatcher.me/
  #Analyzes codebase
  gem 'metric_fu'
    #https://github.com/metricfu/metric_fu
  gem 'meta_request','0.2.1'
  gem 'pry'
  gem 'pry-doc'
  gem 'quiet_assets'
  gem 'rack-mini-profiler'
  gem 'railroady'
  gem 'rails-footnotes', '>= 3.7.5.rc4'
  gem 'request-log-analyzer'
  gem 'smusher'
  gem 'dotenv-rails'
    #https://gist.github.com/cjolly/6265302
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'pg', '0.15.1' #Remove if deploying to PDMagic or other server with MYSQL installed
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

#Opens new browser window with email content instead of sending
#TODO: Move into DEV group once testing phase is completed
#gem 'letter_opener' - replaced with mail opener
  #http://railscasts.com/episodes/104-exception-notifications-revised
#WYSIWYG editor
gem 'tinymce-rails'
  #http://www.tinymce.com/
  #http://richonrails.com/articles/adding-tinymce-to-your-rails-application
#Add sorting/paginating/searching capability to HTML data tables
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
  #http://datatables.net/index
  #http://railscasts.com/episodes/340-datatables
#For GUI components like datepicker
gem 'jquery-ui-rails'
#Emails exceptions to specified admins - config/production/environments/*
gem 'exception_notification'
  #https://github.com/smartinez87/exception_notification/tree/v4.0.0
  #http://railscasts.com/episodes/104-exception-notifications-revised?view=asciicast
gem 'bootstrap-sass'
#For location search
gem 'geokit-rails'
#for cron jobs
gem 'whenever', require: false
  #http://railscasts.com/episodes/164-cron-in-ruby-revised
