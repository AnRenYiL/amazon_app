FactoryBot.define do
  factory :vote do
    is_vote { false }
    review { nil }
    user { nil }
  end
end
