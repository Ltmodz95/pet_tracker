# frozen_string_literal: true

# Restful controller for Pet resource
class PetsController < ApplicationController
  def index
    render json: Pet.all
  end

  def create
    render json: Pet.create(pet_params)
  end

  def show
    render json: Pet.find(params[:id].to_i)
  end

  def out_of_zone
    Pet.all
  end

  private

  def pet_params
    params.permit(:pet_type, :tracker_type, :owner_id, :lost_tracker, :in_zone)
  end
end
