FactoryBot.define do
  factory :user do
    name { 'example' }
    age { 10 }

    trait :with_profile do
      after(:build) do |user, _ev|
        create(:user_profile, user: user)
      end
    end
  end
end
