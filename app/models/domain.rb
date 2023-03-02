class Domain < ApplicationRecord
  has_many :pings, dependent: :destroy
  validates :name, format: { with: /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}/ }, uniqueness: true
end
