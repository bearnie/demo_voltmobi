FactoryGirl.define do

  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    name "MyString"
    login "MyString"
    password "Password"
    date_of_birth "2015-12-16"
    disabled false
  end

  factory :admin, class: User do
    email
    name "MyString"
    login "admin"
    password "Password"
    date_of_birth "2015-12-16"
    disabled false
    roles {[:admin]}
  end

end
