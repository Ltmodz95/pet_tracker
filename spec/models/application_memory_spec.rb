require 'rails_helper'

RSpec.describe ApplicationMemory do
  subject { ApplicationMemory }

  before(:each) do
    subject.instance_variable_set(:@pets, {})
    subject.instance_variable_set(:@tracker_id, 1)
    subject.instance_variable_set(:@pet_id, 1)
    subject.instance_variable_set(:@pets_tracker_status, {})
  end

  describe '.all' do
    context 'retriving all the created pets' do
      it do
        subject.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1)
        subject.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1)

        expect(subject.all.count).to be 2
      end
    end
  end

  describe '.create' do
    let(:pet_data) { { "pet_type": 'cat', "tracker_type": 'big', "in_zone": true, "owner_id": 1, "id": 1 } }
    context 'creating a pet with the correct data' do
      it do
        expect(subject.create(pet_type: 'cat', tracker_type: 'big', in_zone: true,
                              owner_id: 1)).to eq(pet_data)
      end
    end
  end
  describe '.find' do
    context 'retriving a pet based on the provided id' do
      let(:pet_data) { { "pet_type": 'cat', "tracker_type": 'big', "in_zone": true, "owner_id": 1, "id": 1 } }
      it do
        subject.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1)
        expect(subject.find(1)).to eq(pet_data)
      end
    end
  end
end
