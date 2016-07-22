FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "MyText"
    private false
    association :creator, factory: :user
  end
end
