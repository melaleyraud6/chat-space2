FactoryBot.define do
  factory :group do
    sequence(:name) {Faker::Team.name}
  end
end

#sequence 連続した
#複数のデータを作るときに使うとランダムなデータが作れる