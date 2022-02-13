module CreateStamp
  class StampCreator < ApplicationService

    def initialize(location_id:, stampbook_id:)
      @location_id = location_id
      @stampbook_id = stampbook_id
      @stamp_status = false
    end

    def call
      create_stamp
    end


    private

    attr_reader :location_id, :stampbook_id

    def create_stamp
      Stamp.create(location_id: location_id, stampbook_id: stampbook_id)
    end

  end
end
