FactoryBot.define do
  factory :newsarticle do
    title { Faker::Food.sushi }
    description { Faker::Food.description }
    view_count { rand(1..10000) }
    published_at { Faker::Date.forward(days: 1) }
    association(:user, factory: :user)
  end
end
