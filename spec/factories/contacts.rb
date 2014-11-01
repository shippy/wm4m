FactoryGirl.define do
  factory :contact do
    user nil
    sequence(:email) {|n| "joe.mc{n}@yahoo.com"}
    sequence(:name) {|n| "Joe McDaniels {n}"}
    sequence(:phone) {|n| "(203) {n}11-1{n}11"}
  end

end
