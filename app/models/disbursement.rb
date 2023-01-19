# frozen_string_literal: true

class Disbursement < ApplicationRecord
  validates :amount, :disbursed_at, presence: true

  belongs_to :merchant
end
