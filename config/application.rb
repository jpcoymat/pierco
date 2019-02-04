require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pierco
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
      
#    config.before_configuration do
#      env_file = File.join(Rails.root, 'config', 'application.yml')
#      YAML.load(File.open(env_file))[Rails.env].each do |key, value|
#        ENV[key.to_s] = value
#      end if File.exists?(env_file)
#    end
#    
    config.action_controller.permit_all_parameters = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.encoding = "utf-8"

    # Enable the asset pipeline
    config.assets.enabled = true
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      enable_starttls_auto: true,
      address: 'smtp.gmail.com',
      port: 587,
      authentication: 'plain',                                                                                                          
      domain: 'pierco.com.co',
      user_name: Rails.application.secrets.email_username,
      password: Rails.application.secrets.email_password
    }
    config.i18n.default_locale = :es

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
