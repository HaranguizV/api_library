FactoryBot.define do
  factory :reviews do
    review { "Buen libro" }
    score { "4.5" }
    user_id { 1 }
    book_id { 1 }
    sequence(:id) { |n| n }
    active { 1 }
  end
end