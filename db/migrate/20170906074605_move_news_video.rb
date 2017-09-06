class MoveNewsVideo < ActiveRecord::Migration
  def up
    add_column :news, :video_embed, :text
    remove_column :news_translations, :video_embed
  end

  def down
    remove_column :news, :video_embed
    add_column :news_translations, :video_embed, :text
  end
end
