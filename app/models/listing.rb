class Listing < ActiveRecord::Base
  has_attached_file :file

  validates :name, presence: true
  validates :description, length: { maximum: 500 }
  validates :file, presence: true
  validates :price, presence: true
  validates :bitcoin_address, presence: true
end
