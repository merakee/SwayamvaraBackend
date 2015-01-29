# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  factory :user_profile do
    user
    user_name {Faker::Lorem.characters(10)}
    birth_year {rand(25)+1970}
    sex {rand(2)==0?"M":"F"}
    sex_preferred {(sex.eql?"M")?"F":"M"}
    height {rand(4)+3}
    weight {rand(200)+50}
   end
end
