FactoryBot.define do
  factory :book do
    name { "Libro por Defecto" }
    score { "4.5" }
    total_reviews { 1 }
    sequence(:id) { |n| n }
    active { 1 }
  end
end