class Url < ApplicationRecord
  has_many :hits, dependent: :destroy

  validates :destination, :slug, presence: true
  validates :destination, url: true
  validates_uniqueness_of :destination, :slug

  before_create :sanitize_destination, :create_slug

 private

  def sanitize_destination
  end

  def create_slug
    slug_length = 6
    while slug.nil?
      temptative = SecureRandom.random_number(36**slug_length).to_s(36).rjust(slug_length, "0")
      slug = temptative if Url.find_by_slug.empty?
    end
  end
end
