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
        subject.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1, lost_tracker: false)
        subject.create(pet_type: 'cat', tracker_type: 'big', in_zone: true, owner_id: 1, lost_tracker: true)

        expect(subject.all.count).to be 2
        expect(subject.all.first).to eq({ "pet_type": 'cat', "tracker_type": 'big', "in_zone": true, "owner_id": 1,
                                          "id": 1, "lost_tracker": false })
      end
    end
  end

  describe '.create' do
    let(:pet_cat_data) do
      { "pet_type": 'cat', "tracker_type": 'big', "in_zone": true, "owner_id": 1, "id": 1, "lost_tracker": true }
    end
    let(:pet_dog_data) { { "pet_type": 'dog', "tracker_type": 'big', "in_zone": true, "owner_id": 1, "id": 1 } }
    context 'creating a dog with the correct data' do
      it do
        expect(subject.create(pet_type: 'dog', tracker_type: 'big', in_zone: true,
                              owner_id: 1)).to eq(pet_dog_data)
      end
    end

    context 'creating a cat with lost tracker attribute' do
      it do
        expect(subject.create(pet_type: 'cat', lost_tracker: true, tracker_type: 'big', in_zone: true,
                              owner_id: 1)).to eq(pet_cat_data)
      end
    end
  end
  describe '.find' do
    context 'retriving a pet based on the provided id' do
      let(:pet_data) { { "pet_type": 'dog', "tracker_type": 'big', "in_zone": true, "owner_id": 1, "id": 1 } }
      it do
        subject.create(pet_type: 'dog', tracker_type: 'big', in_zone: true, owner_id: 1)
        expect(subject.find(1)).to eq(pet_data)
      end
    end
  end
end
