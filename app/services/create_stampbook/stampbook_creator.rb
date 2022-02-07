module CreateStampbook
  class StampbookCreator < ApplicationService

    include Rails.application.routes.url_helpers


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
    end

    def stampbook_save?(stampbook)
      if stampbook.save
        location_ids.each do |location_id|
          Stamp.create(location_id: location_id, stampbook_id: stampbook.id, stamp_status: false)
        end
      end
    end

  end
end






