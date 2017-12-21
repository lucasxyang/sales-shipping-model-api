require 'rails_helper'

RSpec.describe CompositeOne, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  # Association test
  it { should belong_to(:product) }
  it { should belong_to(:category) }
end
