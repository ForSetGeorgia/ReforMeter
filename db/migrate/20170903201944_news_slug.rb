class NewsSlug < ActiveRecord::Migration
  def change
    add_column :news, :slug, :string
    add_column :news_translations, :slug, :string

    add_index :news, :slug, unique: true
    add_index :news_translations, :slug
  end
end
