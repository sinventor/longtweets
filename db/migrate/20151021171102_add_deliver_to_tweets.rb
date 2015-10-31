class AddDeliverToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :deliver, :boolean
  end
end
