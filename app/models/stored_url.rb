require 'uri'
class StoredUrl < ApplicationRecord
  has_many :hits, dependent: :destroy

  validates :destination, :slug, presence: true
  validates :destination, format: {with: URI.regexp}
  validates_uniqueness_of :destination, :slug

  before_validation :create_slug, on: :create

  # Override to_param
  def to_param
    slug.parameterize
  end

 private

  def create_slug
    slug_size = 6
    slug = nil
    while slug.nil?
      temp = slug_size.times.map { [*'0'..'9', *'a'..'z'].sample }.join
      encontrado = StoredUrl.find_by_slug(temp)
      slug = temp if StoredUrl.find_by_slug(temp).nil?
    end
    self.slug = slug
  end
end
