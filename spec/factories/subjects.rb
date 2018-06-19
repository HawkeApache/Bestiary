FactoryBot.define do
  factory :subject do
    sequence(:name) {|n| Faker::Witcher.witcher + "#{n}_"}
    description "Faker::Witcher.quote"
    ects 2
    rating 0.0
  end
end