class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.text :name
      t.text :feedback

      t.timestamps
    end
  end
end
