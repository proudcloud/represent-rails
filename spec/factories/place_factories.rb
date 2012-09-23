FactoryGirl.define do

  factory :place do |p|
    p.title "Vanilla company"
    p.type "startup"
    p.address "123 Sesame Street"
    p.uri "www.sample.com"
    p.description "Startup description"
    p.owner_name "Test User"
    p.owner_email "test@user.com"
    p.date "test"

    trait :startup do
      before :create do
        p.title "Startup Company"
        p.type  "startup"
      end
    end

    trait :accelerator do
      before :create do
        p.title "Accelerator Company"
        p.type  "accelerator"
      end
    end

    trait :incubator do
      before :create do
        title "Incubator Company"
        type  "incubator"
      end
    end

    trait :coworking do
      before :create do
        title "Coworking Company"
        type  "coworking"
      end
    end

    trait :investor do
      before :create do
        title "Investor Company"
        type  "investor"
      end
    end

    trait :service do
      before :create do
        title "Service Company"
        type  "service"
      end
    end

    trait :event do
      before :create do
        title "Event Company"
        type  "event"
        date { 2.days.from_now }
      end
    end

  end

end
