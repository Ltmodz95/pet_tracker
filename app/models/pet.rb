# frozen_string_literal: true

class Pet < ApplicationMemory
  VALID_TRACKER_TYPES = {
    'cat' => %w[small big],
    'dog' => %w[small medium big]
  }.freeze

  attr_accessor :owner_id, :pet_type, :tracker_type, :in_zone, :lost_tracker

  validates :owner_id, presence: true
  validates :pet_type, inclusion: { in: %w[cat dog] }
  validates :tracker_type, inclusion: { in: %w[small medium big] }
  validates :in_zone, inclusion: { in: [true, false] }
  validate :tracker_valid

  private

  def tracker_valid
    return if VALID_TRACKER_TYPES[pet_type].include?(tracker_type)

    errors.add(:invalid_tracker, 'Tracker type is not compatibale with this pet')
  end
end
