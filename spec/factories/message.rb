FactoryBot.define do
  factory :message do
    body {Faker::Lorem.sentence}   # 文章を作成
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    user
    group
  end
end

# 画像データについてはFakerで生成しません

# Rails.rootの意味は/Users/~~/アプリケーションまでのパスを取得しています