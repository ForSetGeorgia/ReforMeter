class CreateNewsSlideshows < ActiveRecord::Migration
  def change
    create_table :news_slideshows do |t|
      t.references :news, index: true, foreign_key: true
      t.attachment :image
      t.integer :sort_order, limit: 1, default: 1

      t.timestamps null: false
    end

    add_index :news_slideshows, :sort_order
  end
end
