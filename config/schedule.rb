# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')
# cronを実行する環境変数周りの設定
ENV.each { |k, v| env(k, v) }
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"
#定期実行したい処理を記入
every 1.day, at: '0:00 am' do
  rake "youtube_data_api:install_channel_playlists"
end
