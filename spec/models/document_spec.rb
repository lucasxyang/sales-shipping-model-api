require 'rails_helper'

RSpec.describe Document, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  # Association test
  # ensure Customer model has a 1:many relationship with the Document model
  # and Document model has a 1:many relationship with DocumentLine model
  it { should have_many(:document_lines).dependent(:destroy) }
  it { should belong_to(:customer)}
  
  # Validation tests
  # ensure columns status is present before saving
  it { should validate_presence_of(:status) }
  #it { should validate_presence_of(:placed_on) }
end
