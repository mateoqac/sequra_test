require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:disbursed_at) }

  it { should belong_to(:merchant) }
end
