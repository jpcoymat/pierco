CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',                              # required
    aws_access_key_id: Rails.application.credentials[Rails.env.to_sym][:aws_access_key],        # required
    aws_secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws_secret_key]  # required
  }
  config.fog_directory  = Rails.application.credentials[Rails.env.to_sym][:aws_bucket]                 # required
end
