class IncreaseDecimalSize < ActiveRecord::Migration
  def up
    change_column :external_indicator_times, :overall_value, :decimal, :precision => 9, :scale => 2
  end

  def down
    change_column :external_indicator_times, :overall_value, :decimal, :precision => 5, :scale => 2
  end
end
