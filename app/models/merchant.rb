# frozen_string_literal: true

class Merchant < ApplicationRecord
  validates :name, :email, :cif, presence: true

  has_many :orders
end
