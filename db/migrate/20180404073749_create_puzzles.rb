class CreatePuzzles < ActiveRecord::Migration
  def up
    create_table :puzzles do |t|
      t.date :date
      t.boolean :is_public, default: false
      t.string :slug

      t.timestamps null: false
    end

    Puzzle.create_translation_table! title: :string, summary: :text, content: :text, embed_code: :text, slug: :string

    add_index :puzzles, :date
    add_index :puzzles, :is_public
    add_index :puzzles, :slug
    add_index :puzzle_translations, :title
    add_index :puzzle_translations, :slug
  end

  def down
    drop_table :puzzles
    Puzzle.drop_translation_table!
  end
end
