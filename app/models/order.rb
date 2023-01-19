# frozen_string_literal: true

class Order < ApplicationRecord
  validates :amount, presence: true

  belongs_to :merchant
  belongs_to :shopper
end
