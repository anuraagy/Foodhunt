class Recipe < ActiveRecord::Base

  belongs_to :user
  has_many   :votes

  validates :title,    :presence => true
  validates :tagline,  :presence => true
  validates :link,     :presence => true
  validates :user,     :presence => true

  def self.ordered
    order("votes_count DESC")
  end
end
