FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password_digest { Faker::Internet.password }
    api_key { "t1h2i3s4_i5s6_l7e8g9i10t11" }
  end
end
