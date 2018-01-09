class DocumentLine < ApplicationRecord
  belongs_to :document
  belongs_to :product
  # validation
  validates_presence_of :qty
end
