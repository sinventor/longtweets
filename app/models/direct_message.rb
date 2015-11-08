class DirectMessage < ActiveRecord::Base

  belongs_to :user
  validates :user, :text, :recipient, presence: true

end
