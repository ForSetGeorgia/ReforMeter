class AddNewsFields < ActiveRecord::Migration
  def up
    # remove all fields
    remove_index "news", ["quarter_id", "reform_id"]
    remove_index "news", ["reform_survey_id"]
    remove_index "news", ["verdict_id"]

    remove_column :news, :quarter_id
    remove_column :news, :verdict_id
    remove_column :news, :reform_survey_id

    # new fields
    add_column :news, :is_public, :boolean, default: false
    add_column :news, :date, :date
    add_column :news, :media_type, :integer, limit: 1
    add_column :news_translations, :summary, :text
    add_column :news_translations, :video_embed, :text

    add_index :news, :is_public
    add_index :news, :date
  end

  def down
    # old fields
    add_column :news, :quarter_id, :integer
    add_column :news, :verdict_id, :integer
    add_column :news, :reform_survey_id, :integer

    add_index "news", ["quarter_id", "reform_id"]
    add_index "news", ["reform_survey_id"]
    add_index "news", ["verdict_id"]

    # new fields
    remove_index :news, :is_public
    remove_index :news, :date

    remove_column :news, :is_public
    remove_column :news, :date
    remove_column :news, :media_type
    remove_column :news_translations, :summary
    remove_column :news_translations, :video_embed

  end

end
