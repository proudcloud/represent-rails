require "spec_helper"

FactoryGirl.factories.each do |factory|
  describe "The #{factory.name} factory" do
    it 'is valid' do
      FactoryGirl.build(factory.name).should be_valid
    end
  end
end
