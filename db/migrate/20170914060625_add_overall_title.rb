class AddOverallTitle < ActiveRecord::Migration
  def change
    add_column :external_indicator_translations, :overall_title, :string
  end
end
