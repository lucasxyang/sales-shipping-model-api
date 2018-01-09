require 'rails_helper'

RSpec.describe Product, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  # Association test
  it { should have_many(:composite_ones) }
  it { should have_many(:document_lines) }

  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
