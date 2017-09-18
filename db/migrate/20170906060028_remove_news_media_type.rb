class RemoveNewsMediaType < ActiveRecord::Migration
  def up
    remove_column :news, :media_type
  end

  def down
    add_column :news, :media_type, :integer, limit: 1
  end
end
