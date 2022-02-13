module CreateStampbook
  class StampbookCreator < ApplicationService

    def initialize(params:, user:, location_ids:)
      @params = params
      @user = user
      @location_ids = location_ids
    end

    def call
      create_stampbook
    end


    private

    attr_reader :params, :user, :location_ids

    def create_stampbook
      stampbook = Stampbook.new(params)
      stampbook.user = user
      stampbook_save?(stampbook)
      stampbook
    end

    def stampbook_save?(stampbook)
      if stampbook.save
        location_ids.each do |location_id|
          CreateStamp::StampCreator.call(location_id: location_id, stampbook_id: stampbook.id)
        end
      end
    end

  end
end






