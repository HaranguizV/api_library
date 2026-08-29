FactoryBot.define do
  factory :users do
    sequence(:id) { |n| n }
    name { "Usuario 1" }
    active { 1 }
  end
end