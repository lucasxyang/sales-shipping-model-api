# spec/factories/documents.rb
FactoryBot.define do
  factory :document do
    status { Faker::Lorem.word }
    placed_on { Faker::Date.between(2.days.ago, Date.today) }
    customer_id nil
  end
end