require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:cif) }

  it { should have_many(:orders) }
end
