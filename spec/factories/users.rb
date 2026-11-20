FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { "password123" }
    role { :user }
  end

  factory :admin, class: "User", parent: :user do
    role { :admin }
  end
end