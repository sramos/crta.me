require 'uri'
class StoredUrl < ApplicationRecord
  has_many :hits, dependent: :destroy

  validates :destination, :slug, presence: true
  validates :destination, format: {with: URI.regexp}
  validates_uniqueness_of :destination, :slug

  before_validation :create_slug, on: :create
  before_validation :complete_protocol

  # Override to_param
  def to_param
    slug.parameterize
  end

  protected

  # Create unique random slug
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

  # Add protocol to URL if not exists
  def complete_protocol
    self.destination = "http://#{self.destination}" unless self.destination[/^https?:\/\//]
  end
end
