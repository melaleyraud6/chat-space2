FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 8)  # Keyword arguments: なし,min_length, max_length, mix_case, special_charactersFaker::Internet.password
    sequence(:name) {Faker::Name.last_name}
    sequence(:email) {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
  end
end