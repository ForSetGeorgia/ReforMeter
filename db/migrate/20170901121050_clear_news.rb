class ClearNews < ActiveRecord::Migration
  def change
    News.destroy_all
  end
end
