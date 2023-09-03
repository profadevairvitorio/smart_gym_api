# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Gyms', type: :request do
  describe 'GET /api/v1/gyms' do
    let!(:gyms) { create_list(:gym, 3) }
    let(:gym_id) { gyms.first.id }

    before { get '/api/v1/gyms' }

    it 'returns a list of gyms' do
      expect(JSON(response.body)).not_to be_empty
      expect(JSON(response.body).count).to eq(3)
    end

    it 'returns a status code :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/gyms/:id' do
    let!(:gym) { create(:gym, name: 'Vitorio GYM') }
    let(:gym_id) { gym.id }

    before { get "/api/v1/gyms/#{gym_id}" }

    context 'when the gym exists' do
      it 'returns the gym' do
        expect(JSON(response.body)).not_to be_empty
        expect(JSON(response.body)['id']).to eq(gym_id)
        expect(JSON(response.body)['name']).to eq('Vitorio GYM')
      end
      it 'returns a status code :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the gym does not exist' do
      let(:gym_id) { 100 }

      it 'returns a status code :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(JSON(response.body)['message']).to match('not found')
      end
    end
  end


end