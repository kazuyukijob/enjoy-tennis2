class CreateTennisCourts < ActiveRecord::Migration[6.1]
  def change
    create_table :tennis_courts do |t|
      #施設名
      t.string :name
      #施設説明
      t.text :explanation
      #住所
      t.string :address
      #経度
      t.float :longitude
      #緯度
      t.float :float

      t.timestamps
    end
  end
end
