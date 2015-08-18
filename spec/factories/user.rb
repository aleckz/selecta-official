FactoryGirl.define do

  factory :user do # FactoryGirl will assume that the parent model of a factory named ":user" is "User".
    email 'salman@selecta.com'
    password '123'
    password_confirmation '123'
  end

end
