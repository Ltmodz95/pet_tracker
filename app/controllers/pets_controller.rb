# frozen_string_literal: true

# Restful controller for Pet resource
class PetsController < ApplicationController
  def index
    render json: Pet.all
  end

  def create
    pet = Pet.new(pet_params)

    return render json: pet.errors.messages unless pet.valid?

    render json: Pet.create(pet_params)
  end

  def show
    render json: Pet.find(params[:id].to_i)
  end

  def out_of_zone
    render json: PetsOutOfZoneService.run
  end

  private

  def pet_params
    params.permit(:pet_type, :tracker_type, :owner_id, :lost_tracker, :in_zone)
  end
end
