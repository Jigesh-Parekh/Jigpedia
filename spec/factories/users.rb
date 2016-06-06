FactoryGirl.define do
  factory :user do 
    #specify peices of a user :  name email confirmed at = Time.now
    password {Faker::Internet.password }
    email {Faker::Internet.email}
    confirmed_at {Time.now}

  end
end
