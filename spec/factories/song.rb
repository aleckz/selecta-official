FactoryGirl.define do

  factory :song do |u|# FactoryGirl will assume that the parent model of a factory named ":user" is "User".
    u.sequence(:soundcloud_id) { |n| n}
  end
end
