class StoredUrl < ApplicationRecord
  has_many :hits, dependent: :destroy

  validates :destination, :slug, presence: true
  validates :destination, url: true
  validates_uniqueness_of :destination, :slug

  before_create :create_slug

 private

  def create_slug
    slug_length = 6
    while slug.nil?
      temp = slug_size.times.map { [*'0'..'9', *'a'..'z'].sample }.join
      slug = temp if StoredUrl.find_by_slug(temp).nil?
    end
  end
end
