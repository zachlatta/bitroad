class Invoice < ActiveRecord::Base
  extend FriendlyId
  friendly_id :code, use: :slugged

  belongs_to :listing
  has_attached_file :file, {
    url: "/system/:hash.:extension",
    hash_secret: Figaro.env.paperclip_hash_secret
  }

  validates :file, presence: true

  private

  def code
    Digest::SHA1.hexdigest self.file.url
  end
end
