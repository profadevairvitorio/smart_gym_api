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
      let!(:gym) { create(:gym, name: 'Vitorio GYM') }
      let(:gym_id) { gym.id }

      it 'returns the gym' do
        expect(JSON(response.body)).to include(gym.attributes.as_json)
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

  describe 'POST /api/v1/gyms' do
    before { post '/api/v1/gyms', params: { gym: gym_attributes }}

    context 'when gym attributes are valid ' do
      let(:gym_attributes) do
        {
          name: 'Vitório GYM',
          document_number: '1234567890',
          document_type: 'cnpj',
          email: 'vitorio@gym.com'
        }
      end

      it 'creates a new gym' do
        expect(JSON.parse(response.body)).to include(gym_attributes.as_json)
      end

      it 'returns a status code :created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when gym attributes are not valid' do
      let(:gym_attributes) { { name: 'foo' } }

      before { post '/api/v1/gyms', params: { gym: gym_attributes }}

      it 'returns the error message' do
        %w[document_number document_type email].each do |attr|
          expect(JSON(response.body)[attr]).to match(["can't be blank"])
        end
      end

      it 'returns a status code :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/gyms/:id' do

    before do
      put "/api/v1/gyms/#{gym_id}", params: { gym: gym_name }
    end

    context 'when the gym exists' do
      let!(:gym) { create(:gym, id: 1, name: 'Vitorio GYM') }
      let(:gym_id) { gym.id }
      let(:gym_name) { { name: 'Updated Gym' } }

      it 'returns a status code :no_content' do
        expect(response).to have_http_status(:no_content)
        expect(gym.reload.name).to eq('Updated Gym')
      end

    end

    context 'when the gym does not exist' do
      let(:gym_id) { 100 }
      let(:gym_name) { { name: 'foo' } }

      before do
        put "/api/v1/gyms/#{gym_id}", params: { gym: gym_name }
      end

      it 'returns a status code :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(JSON(response.body)['message']).to match('not found')
      end
    end
  end

  describe 'DELETE /api/v1/gyms/:id' do
    before { delete "/api/v1/gyms/#{gym_id}" }

    context 'when the gym exists' do
      let!(:gym) { create(:gym) }
      let(:gym_id) { gym.id }

      it 'returns a status code :no_content' do
        expect(response).to have_http_status(:no_content)
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
