require 'rails_helper'

RSpec.describe DocumentLine, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  # Association test
  # ensure Document model has a 1:many relationship with the DocumentLine model
  # and Product model has a 1:many relationship with DocumentLine model
  it { should belong_to(:document) }
  it { should belong_to(:product) }
  # Validation tests
  # ensure columns qty is present before saving
  it { should validate_presence_of(:qty) }
end
