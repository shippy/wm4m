FactoryGirl.define do
  factory :response do
    kind { [1, 2].sample }
    level { [1, 2, 3].sample }
    datetime { DateTime.now }
    user nil
  end

end
