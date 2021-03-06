# spec/models/ride_spec.rb

require 'rails_helper'

RSpec.describe Ride, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.create(:ride)).to be_valid
  end

  it 'has a state created' do
    factory = FactoryBot.build(:ride, from: 'a', to: 'b')
    expect(factory.created?).to be_truthy
  end

  it 'has a valid code' do
    factory = FactoryBot.build(:ride, from: 'a', to: 'b')
    expect(factory.code).not_to be_nil
  end

  it 'has a 4 characters code' do
    factory = FactoryBot.build(:ride, from: 'a', to: 'b')
    expect(factory.code.size).to eq(4)
  end

  it "is invalid without a departure" do
    factory = FactoryBot.build(:ride, from: nil)
    expect(factory).not_to be_valid
  end

  it "is invalid without a destination" do
    factory = FactoryBot.build(:ride, to: nil)
    expect(factory).not_to be_valid
  end

  it "has a state started" do
    factory = FactoryBot.build(:ride, state: 'created')
    factory.start
    factory.update(state: factory.state)
    factory.reload
    expect(factory.started?).to be_truthy
  end
end
