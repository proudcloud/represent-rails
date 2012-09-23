require "spec_helper"

FactoryGirl.factories.each do |factory|
  describe "The #{factory.name} factory" do
    it 'is valid' do
      if factory.defined_traits.first.present?
        factory.defined_traits.each do |trait|
          FactoryGirl.build(factory.name, trait.name).should be_valid
        end
      else
        FactoryGirl.build(factory.name).should be_valid
      end
    end
  end
end
