class ChangeNewUrlLength < ActiveRecord::Migration
  def up
    change_column :news_translations, :url, :string, limit: 500
  end
  def down
    change_column :news_translations, :url, :string, limit: 255
  end
end
