# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.office365.com',
  :port           => '587',
  :authentication => :login,
  :user_name      => ENV['SMTP_USERNAME'],
  :password       => ENV['SMTP_PASSWORD'],
  # :domain         => 'canadiancannabis.co',
  :enable_starttls_auto => true
}