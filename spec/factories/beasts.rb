FactoryBot.define do
  factory :beast do
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    degree "mgr"
  end
end
