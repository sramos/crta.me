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
  end
end
