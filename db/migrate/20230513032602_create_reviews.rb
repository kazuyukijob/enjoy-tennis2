class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      #レビュータイトル
      t.string :review_title
      #レビュー文
      t.text :review_body
      t.integer :user_id
      t.integer :tennis_court_id

      t.timestamps
    end
  end
end
