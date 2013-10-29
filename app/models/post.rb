class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title
  after_save :set_slug

  validates_presence_of :title, :content

  def set_slug
    self.slug = "new-post"
  end

  private

  def titleize_title
    self.title = title.titleize
  end
end
