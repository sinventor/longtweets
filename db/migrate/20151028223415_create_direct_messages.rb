class CreateDirectMessages < ActiveRecord::Migration
  def change
    create_table :direct_messages do |t|
      t.text :text
      t.string :recipient
      t.references :user, index: true
      t.boolean :deliver

      t.timestamps
    end
  end
end
