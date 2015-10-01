class AddDefaultValueToHitsAndTriesFromQuestion < ActiveRecord::Migration
  def change
    change_column_default(:questions, :hits, 0)
    change_column_default(:questions, :tries, 0)
  end
end
