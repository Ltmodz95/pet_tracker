# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validates' do
    context 'when owner_id is not present' do
      let(:pet) { build(:pet, owner_id: nil) }
      it { expect(pet.valid?).to be_falsey }
    end

    context 'when tracker_type is not present' do
      let(:pet) { build(:pet, tracker_type: nil) }
      it { expect(pet.valid?).to be_falsey }
    end

    context 'when tracker_type is not an accepted type' do
      let(:pet) { build(:pet, tracker_type: 'nano') }
      it { expect(pet.valid?).to be_falsey }
    end

    context 'when tracker_type is an accepted type' do
      let(:pet) { build(:pet, tracker_type: %w[small medium big].sample) }
      it { expect(pet.valid?).to be_truthy }
    end

    context 'when tracker_type is of medium size for cat' do
      let(:pet) { build(:pet, pet_type: 'cat', tracker_type: 'medium') }
      it { expect(pet.valid?).to be_falsey }
    end

    context 'when tracker_type is of small or big size for cat' do
      let(:pet) { build(:pet, pet_type: 'cat', tracker_type: %w[small big].sample) }
      it { expect(pet.valid?).to be_truthy }
    end

    context 'when in_zone is not present' do
      let(:pet) { build(:pet, in_zone: nil) }
      it { expect(pet.valid?).to be_falsey }
    end
  end
end
