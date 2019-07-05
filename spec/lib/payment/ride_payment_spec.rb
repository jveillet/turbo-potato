# spec/lib/payment/ride_payment_spec.rb

require 'payment/ride_payment'

require 'spec_helper'

include RidePayment

RSpec.describe RidePayment do
  describe '#bill' do
    describe 'The ride is at state created' do
      it 'creates the bill ' do
        ride = FactoryBot.create(:ride, from: 'a', to: 'b')
        subject = bill(ride)
        expect(subject).to be_truthy
      end
    end

    describe 'The ride is not at state created' do
      it 'does not create the bill ' do
        ride = FactoryBot.create(:ride, from: 'a', to: 'b', state: 'canceled')
        subject = bill(ride)
        expect(subject).to be_falsey
      end
    end
  end

  describe '#pay' do
    describe 'The ride is at state started' do
      it 'pays the bill ' do
        ride = FactoryBot.create(:ride, from: 'a', to: 'b', state: 'started')
        subject = pay(ride)
        expect(subject).to be_truthy
      end
    end

    describe 'The ride is not at state started' do
      it 'does not pay the bill ' do
        ride = FactoryBot.create(:ride, from: 'a', to: 'b', state: 'canceled')
        subject = pay(ride)
        expect(subject).to be_falsey
      end
    end
  end

  describe '#reimburse' do
    describe 'The ride is at state started or created' do
      it 'reimburses the bill ' do
        ride = FactoryBot.create(:ride, from: 'a', to: 'b', state: 'started')
        subject = reimburse(ride)
        expect(subject).to be_truthy
      end
    end

    describe 'The ride is not at state started' do
      it 'does not reimburse the bill ' do
        ride = FactoryBot.create(:ride, from: 'a', to: 'b', state: 'canceled')
        subject = reimburse(ride)
        expect(subject).to be_falsey
      end
    end
  end
end
