class AddPuzzleReform < ActiveRecord::Migration
  def change
    add_reference :puzzles, :reform, index: true
  end
end
