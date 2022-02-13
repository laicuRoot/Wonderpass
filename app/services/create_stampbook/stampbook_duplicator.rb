module CreateStampbook
  class StampbookDuplicator < ApplicationService

    def initialize(stampbook_id:, user:)
      @stampbook_id = stampbook_id
      @user = user
    end

    def call
      clone
    end


    private

    attr_reader :stampbook_id, :user

    def clone
      stampbook = find_stampbook_by_id(stampbook_id)
      newbook = can_be_cloned?(stampbook)
      newbook.user = user
      stampbook_save?(stampbook, newbook)
    end

    def stampbook_save?(stampbook, newbook)
      Stampbook.create_stamps(stampbook, newbook) if newbook.save
      newbook
    end

    def can_be_cloned?(stampbook)
      if stampbook.status == true
        stampbook.dup
      end
    end

    def find_stampbook_by_id(stampbook_id)
      Stampbook.find(stampbook_id)
    end

  end
end
