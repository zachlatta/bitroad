require 'bitcoin'

class Listing < ActiveRecord::Base
  has_attached_file :file
  has_many :invoices

  validate :valid_bitcoin_address
  validates :name, presence: true
  validates :description, length: { maximum: 500 }
  validates :file, presence: true
  validates :price, presence: true, numericality: { greater_than: 0.005,
                                                    less_than: 0.05 }
  validates :bitcoin_address, presence: true

  private

  def valid_bitcoin_address
    if !Bitcoin::valid_address?(bitcoin_address)
      errors.add(:bitcoin_address, "must be valid")
    end
  end
end
