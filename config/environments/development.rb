JobBoardDemo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  #set mailer config
  config.action_mailer.default_url_options = { :host => "localhost:3000" }

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { address: 'localhost',
                                         port: 1025 }

  JobBoardDemo::Application.config.middleware.use ExceptionNotification::Rack,
  #:ignore_exceptions => ['ActionView::Template::Error'] + ExceptionNotifier.ignored_exceptions,
  :email => {
    :email_prefix => "[Job Board Demo Application - ERROR] ",
    :sender_address => %{"Auto-notification" <JobBoardDemo@TheArtOfTechLLC.com>},
    :exception_recipients => %w{john.e.chase@gmail.com}
  }

  #Shows email in a new browser instead of delivering it
  #config.action_mailer.delivery_method = :letter_opener
  #PRODUCTION version:
  ##:sendmail
  ## Defaults to:
  ## config.action_mailer.sendmail_settings = {
  #   :location => '/usr/sbin/sendmail',
  #   :arguments => '-i -t'
  # }
  config.after_initialize do
    Bullet.bullet_logger = true
    # Bullet.console = true
    # Bullet.growl = false
    # # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #                 # :password => 'bullets_password_for_jabber',
    #                 # :receiver => 'your_account@jabber.org',
    #                 # :show_online_status => true }
    # Bullet.rails_logger = true
    # Bullet.airbrake = true
    Bullet.add_footer = true
  end
end
