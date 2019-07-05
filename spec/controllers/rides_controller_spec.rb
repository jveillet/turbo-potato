# spec/controllers/rides_controller_spec.rb

require 'rails_helper'

RSpec.describe RidesController, type: :controller do

  describe 'GET #index' do
    it 'populates an array of rides' do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', created_at: '2019-01-01', updated_at: '2019-01-01')
      get :index
      expect(assigns(:rides)).to eq([ride])
    end

    it 'responds successfully' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it "assigns the requested ride to @ride" do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', created_at: '2019-01-01', updated_at: '2019-01-01')
      get :show, params: {  id: ride.id }
      expect(assigns(:ride)).to eq(ride)
    end

    it 'renders the #show view' do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', created_at: '2019-01-01', updated_at: '2019-01-01')
      get :show, params: { id: ride.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'PUT #start_ride' do
    it "redirects to the rides list" do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', state: 'created')
      put(:start_ride, params: { id: ride.id, ride_id: ride.id })
      expect(response).to redirect_to(:rides)
    end

    it 'changes the state to started' do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', state: 'created')
      put(:start_ride, params: { id: ride.id, ride_id: ride.id })
      ride.reload
      expect(ride.state).to eq('started')
    end

    it "doesn't change the state if it's different from created" do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', state: 'cancelled')
      put(:start_ride, params: { id: ride.id, ride_id: ride.id })
      ride.reload
      expect(ride.state).not_to eq('started')
    end
  end

  describe 'PUT #cancel_ride' do
    it "redirects to the rides list" do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', state: 'created')
      put(:cancel_ride, params: { id: ride.id, ride_id: ride.id })
      expect(response).to redirect_to(:rides)
    end

    it 'changes the state to cancelled' do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', state: 'created')
      put(:cancel_ride, params: { id: ride.id, ride_id: ride.id })
      ride.reload
      expect(ride.cancelled?).to be_truthy
    end

    it "doesn't change the state if it's different from created or started" do
      ride = FactoryBot.create(:ride, id: '1', from: 'a', to: 'b', state: 'foo')
      put(:cancel_ride, params: { id: ride.id, ride_id: ride.id })
      ride.reload
      expect(ride.state).to eq('foo')
    end
  end
end
