class AddPuzzleImages < ActiveRecord::Migration
  def up
    add_attachment :puzzles, :image_en
    add_attachment :puzzles, :image_ka
  end

  def down
    remove_attachment :puzzles, :image_en
    remove_attachment :puzzles, :image_ka
  end
end
