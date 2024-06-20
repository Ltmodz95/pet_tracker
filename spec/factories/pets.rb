# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    pet_type { 'dog' }
    tracker_type { 'small' }
    owner_id { 1 }
    in_zone { false }
  end
end
