class PublicChat < ActiveRecord::Base

  belongs_to :user
  self.table_name = 'public_chat'
  validates_presence_of :text
  validates_presence_of :user_id

end