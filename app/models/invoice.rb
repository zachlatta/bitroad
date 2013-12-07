class Invoice < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :file

  validates :file, presence: true
end
