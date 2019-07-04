# spec/factories/rides.rb

FactoryBot.define do
  factory :ride do
    code { 'abc1' }
    from { 'fromDeparture' }
    to { 'toDestination' }
    state { 'created' }
  end
end
