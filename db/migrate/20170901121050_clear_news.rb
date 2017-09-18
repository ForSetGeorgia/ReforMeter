class ClearNews < ActiveRecord::Migration
  def change
    News.delete_all
  end
end
