# frozen_string_literal: true

# A service to build the report on how many pets are outside
# the power saving mode, it is dynamically which means it can
# accomadate any type or trackers or any number pet types
class PetsOutOfZoneService
  def self.run
    grouped_trackers = Pet.all.group_by { _1['tracker_type'] }

    pets_out_of_zone = {}

    grouped_trackers.each do |tracker|
      key = tracker[0]
      pets = tracker[1]
      pets_out_of_zone[key] ||= {}
      pets.each do |pet|
        pets_out_of_zone[key][pet['pet_type']] ||= 0
        pets_out_of_zone[key][pet['pet_type']] += 1 unless pet['in_zone']
      end
    end

    pets_out_of_zone
  end
end
