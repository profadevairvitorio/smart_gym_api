# frozen_string_literal: true

class Gym < ApplicationRecord
  validates :name, :document_number, :document_type, :email, presence: true
end
