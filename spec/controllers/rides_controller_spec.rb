# spec/controllers/rides_controller_spec.rb

require 'rails_helper'

RSpec.describe RidesController, type: :controller do

  before :each do
    @ride = FactoryBot.create(:ride, from: 'a', to: 'b')
  end

  describe 'GET #index' do
    it 'populates an array of rides' do
      get :index
      expect(assigns(:rides)).to eq([@ride])
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
      get :show, params: {  id: @ride.id }
      expect(assigns(:ride)).to eq(@ride)
    end

    it 'renders the #show view' do
      get :show, params: { id: @ride.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'PUT #start_ride' do
    it "redirects to the rides list" do
      put(:start_ride, params: { id: @ride.id, ride_id: @ride.id })
      expect(response).to redirect_to(:rides)
    end

    it 'changes the state to started' do
      put(:start_ride, params: { id: @ride.id, ride_id: @ride.id })
      @ride.reload
      expect(@ride.started?).to be_truthy
    end

    it "doesn't change the state if it's different from created" do
      ride = FactoryBot.create(:ride, from: 'a', to: 'b', state: 'foo')
      put(:start_ride, params: { id: ride.id, ride_id: ride.id })
      ride.reload
      expect(ride.state).to eq('foo')
    end
  end

  describe 'PUT #cancel_ride' do
    it "redirects to the rides list" do
      put(:cancel_ride, params: { id: @ride.id, ride_id: @ride.id })
      expect(response).to redirect_to(:rides)
    end

    it 'changes the state to cancelled' do
      put(:cancel_ride, params: { id: @ride.id, ride_id: @ride.id })
      @ride.reload
      expect(@ride.cancelled?).to be_truthy
    end

    it "doesn't change the state if it's different from created or started" do
      ride = FactoryBot.create(:ride, from: 'a', to: 'b', state: 'foo')
      put(:cancel_ride, params: { id: ride.id, ride_id: ride.id })
      ride.reload
      expect(ride.state).to eq('foo')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new ride in the database' do
        expect do
          post :create, params: { from: 'a', to: 'b' }
        end.to change(Ride, :count).by(1)
      end

      it 'redirects to the rides list' do
        post :create, params: { from: 'a', to: 'b' }
        expect(response).to redirect_to(:rides)
      end
    end
  end

  describe 'DELETE #destroy' do
    it "deletes the ride" do
      expect{
        delete :destroy, params: { id: @ride.id, ride_id: @ride.id }
     }.to change(Ride, :count).by(-1)
    end
  end
end
