# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
  end
end