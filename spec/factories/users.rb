# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email,100) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation {password}
    user_type_id 2
  # required if the Devise Confirmable module is used
  # confirmed_at Time.now
  end

  trait :anonymous do
    email nil
    password nil
    password_confirmation nil
    user_type_id 1
  end

end