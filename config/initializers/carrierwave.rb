CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.credentials.aws[:access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    # use_iam_profile:       true,
    region:                'ap-northeast-1',
    host:                  's3.example.com',
    endpoint:              'https://s3.example.com:8080'
  }
  config.fog_directory  = 'user-tube-bucket'
  config.fog_public     = false
  config.cache_storage = :file
end