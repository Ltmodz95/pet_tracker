# frozen_string_literal: true

# A simple implementation for an in memory storage
# With database relation imitatied into seperate hashmaps
# Such as pets & pets_tracker_status, since we only have the lost_tracker available
# for cats, so we have created a separate hashmap the is liked to the pet through it's id
# which acts as a belongs_to/has_one relationship in the database

class ApplicationMemory
  include ActiveModel::Model
  include ActiveModel::Validations

  @pets = {}.with_indifferent_access
  @pets_tracker_status = {}.with_indifferent_access
  @pet_id = 1
  @tracker_id = 1

  class << self
    def create(attrs)
      lost_tracker = attrs.delete(:lost_tracker)
      pet = Pet.new(**attrs)

      return unless pet.valid?

      id = @pet_id
      @pets[id] = { id: @pet_id }.merge(**attrs)
      @pet_id += 1

      if pet.pet_type == 'cat' && !lost_tracker.nil?
        @pets_tracker_status[id] = { id: @tracker_id, lost_tracker: }
        @tracker_id += 1
      end

      return @pets[id].merge({ lost_tracker: @pets_tracker_status[id][:lost_tracker] }) if @pets_tracker_status[id]

      @pets[id]
    end

    def find(id)
      return @pets[id].merge({ lost_tracker: @pets_tracker_status[id] }) if @pets_tracker_status[id]

      @pets[id]
    end

    def all
      @pets.map do |key, val|
        @pets_tracker_status[key] ? val.merge(lost_tracker: @pets_tracker_status[key][:lost_tracker]) : val
      end
    end
  end
end
