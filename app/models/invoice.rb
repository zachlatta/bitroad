class Invoice < ActiveRecord::Base
  extend FriendlyId
  friendly_id :code, use: :slugged

  belongs_to :listing
  has_attached_file :file

  validates :file, presence: true
  validates :session_id, presence: true

  private

  def code
    Digest::SHA1.hexdigest self.file.url
  end
end
