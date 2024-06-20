# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pets', type: :request do
  before(:each) do
    Pet.instance_variable_set(:@pets, {})
    Pet.instance_variable_set(:@pets_tracker_status, {})
  end

  describe 'GET /pets' do
    context 'returns 200' do
      it do
        get '/pets'
        expect(response).to have_http_status(200)
      end
    end

    context 'returns list of created pets' do
      it do
        5.times do
          Pet.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1, lost_tracker: true)
        end
        get '/pets'

        expect(JSON.parse(response.body).size).to eq 5
      end
    end
  end

  describe 'GET /pets/id' do
    context 'returns 200' do
      it do
        Pet.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1, lost_tracker: true)
        get '/pets/1'
        expect(response).to have_http_status(200)
      end
    end

    context 'returns list of created pets' do
      it do
        Pet.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1, lost_tracker: true)
        get '/pets/1'
        expect(response.body).to eq({ "id": 1, "pet_type": 'cat', "tracker_type": 'big', "in_zone": true,
                                      "owner_id": 1, "lost_tracker": true }.to_json)
      end
    end
  end

  describe 'POST /pets' do
    context 'When creating a pet' do
      it do
        post '/pets', params: { "pet_type": 'cat', "tracker_type": 'big', "in_zone": true,
                                "owner_id": 1, "lost_tracker": true }, as: :json
        expect(response.body).to eq({ "id": 1, "pet_type": 'cat', "tracker_type": 'big',
                                      "owner_id": 1, "in_zone": true, "lost_tracker": true }.to_json)
      end
    end
  end

  describe 'GET /pets_out_of_zone' do
    context 'when getting pets that are outside of the zone' do
      let(:result) do
        { 'big': { 'cat': 2, 'dog': 3 }, "small": { 'cat': 2, 'dog': 3 }, 'medium': { 'dog': 3 } }
      end
      it do
        2.times do
          Pet.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1, lost_tracker: true)
          Pet.create(pet_type: 'cat', tracker_type: 'big', in_zone: false, owner_id: 1, lost_tracker: true)
          Pet.create(pet_type: 'cat', tracker_type: 'small', in_zone: false, owner_id: 1, lost_tracker: true)
        end
        3.times do
          Pet.create(pet_type: 'dog', tracker_type: 'big', in_zone: false, owner_id: 1)
          Pet.create(pet_type: 'dog', tracker_type: 'medium', in_zone: false, owner_id: 1)
          Pet.create(pet_type: 'dog', tracker_type: 'small', in_zone: false, owner_id: 1)
          Pet.create(pet_type: 'dog', tracker_type: 'small', in_zone: true, owner_id: 1)
        end

        get '/pets_out_of_zone'

        expect(response.body).to eq(result.to_json)
      end
    end
  end
end
