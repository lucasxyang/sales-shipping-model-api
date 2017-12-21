require 'rails_helper'

RSpec.describe Customer, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  # Association test
  # ensure Customer model has a 1:many relationship with the Document model
  it { should have_many(:documents).dependent(:destroy) }
  # Validation tests
  # ensure columns first_name and last_name are present before saving
  it { should validate_presence_of(:first_name) }
  #it { should validate_presence_of(:last_name) }
end
