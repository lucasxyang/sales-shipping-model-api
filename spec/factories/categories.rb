# spec/factories/products.rb
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
  end
end