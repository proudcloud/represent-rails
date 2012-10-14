FactoryGirl.define do

  factory :place do
    title "Vanilla Company"
    type "startup"
    address "123 Sesame Street"
    uri "www.sample.com"
    description "Startup description"
    owner_name "Test User"
    owner_email "test@user.com"

    trait :startup_trait do
      title "Startup Company"
      type  "startup"
    end

    trait :accelerator_trait do
      title "Accelerator Company"
      type  "accelerator"
    end

    trait :incubator_trait do
      title "Incubator Company"
      type  "incubator"
    end

    trait :coworking_trait do
      title "Coworking Company"
      type  "coworking"
    end

    trait :investor_trait do
      title "Investor Company"
      type  "investor"
    end

    trait :consulting_trait do
      title "Consulting Company"
      type  "service"
    end

    trait :event_trait do
      title "Event Company"
      type  "event"
      date { 2.days.from_now.to_s }
    end

    trait :past_event_trait do
      title "Past Event Company"
      type  "event"
      date { 1.week.ago.to_s }
    end

    trait :approved_trait do
      approved true
    end

    factory :startup, traits: [:startup_trait]
    factory :accelerator, traits: [:accelerator_trait]
    factory :incubator, traits: [:incubator_trait]
    factory :coworking, traits: [:coworking_trait]
    factory :investor, traits: [:investor_trait]
    factory :consulting, traits: [:consulting_trait]
    factory :event, traits: [:event_trait]
    factory :past_event, traits: [:past_event_trait]

  end

end
