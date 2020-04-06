require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace2
  class Application < Rails::Application
    config.time_zone = 'Tokyo'                     # 都市名を設定することでタイムゾーンを変更
    config.active_record.default_timezone = :local # DB レコードの読み書きに対する設定.:local を設定した場合、DBが動作するサーバのタイムゾーンが使用されます。
    config.generators do |g|  
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
    config.i18n.default_locale = :ja  # フラッシュメッセージの日本語化
  end
end

#-------------------------11〜16行目----------------------------------------------------------------------------------------------------------------------
# 'rails g'コマンドでコントローラを作成すると、生成したファイルに対応したスタイルシート・ヘルパー・Javascript・アプリケーションをテストするためのファイルが同時に生成されてしまうのを防ぐために記入