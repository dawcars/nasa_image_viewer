class CreateNasaImages < ActiveRecord::Migration[5.2]
  def change
    create_table :nasa_images do |t|
      t.string :center
      t.datetime :date_image_created
      t.text :description
      t.text :keywords
      t.string :media_type
      t.string :nasa_id
      t.string :title
      t.text :image_collection_url
      t.text :thumbnail_url

      t.timestamps
    end
  end
end
