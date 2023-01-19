require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:amount) }

  it { should belong_to(:shopper) }
  it { should belong_to(:merchant) }
end
