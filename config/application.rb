require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace2
  class Application < Rails::Application
    config.generators do |g|  
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
  end
end

#-------------------------11〜16行目----------------------------------------------------------------------------------------------------------------------
# 'rails g'コマンドでコントローラを作成すると、生成したファイルに対応したスタイルシート・ヘルパー・Javascript・アプリケーションをテストするためのファイルが同時に生成されてしまうのを防ぐために記入