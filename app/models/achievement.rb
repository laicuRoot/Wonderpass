class Achievement < ApplicationRecord
  belongs_to :stampbook
  belongs_to :badge
  # validates scope
end
