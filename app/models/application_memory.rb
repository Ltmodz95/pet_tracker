# frozen_string_literal: true

# A simple implementation for an in memory storage
class ApplicationMemory
  include ActiveModel::Model
  include ActiveModel::Validations
  @pets = {}.with_indifferent_access
  @pets_tracker_status = {}.with_indifferent_access
  @pet_id = 1
  @tracker_id = 1
  class << self
    def create(attrs)
      pet = Pet.new(**attrs)

      return unless pet.valid?

      id = @pet_id
      @pets[id] = { id: @pet_id }.merge(**attrs)
      @pet_id += 1
      @pets[id]
    end

    def find(id)
      @pets[id]
    end

    def all
      @pets.values
    end
  end
end
