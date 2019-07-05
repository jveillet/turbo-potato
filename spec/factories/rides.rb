# spec/factories/rides.rb

FactoryBot.define do
  factory :ride do
    from { 'fromDeparture' }
    to { 'toDestination' }
    state { 'created' }
  end
end
