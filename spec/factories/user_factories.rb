FactoryGirl.define do
  factory :user do
    email 'user@sample.com'
    password 'letmein'
    password_confirmation 'letmein'
  end
end
