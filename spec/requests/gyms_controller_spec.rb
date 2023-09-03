# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Gyms', type: :request do
  let!(:gyms) { create_list(:gym, 3) }

  describe 'GET /api/v1/gyms' do
    before { get '/api/v1/gyms' }

    it 'returns a list of gyms' do
      expect(JSON(response.body)).not_to be_empty
      expect(JSON(response.body).count).to eq(3)
    end

    it 'returns a status code :ok' do
      expect(response).to have_http_status(:ok)
    end
  end
end