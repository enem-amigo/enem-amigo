class AddDefaultValueToImageToQuestion < ActiveRecord::Migration
  def change
    change_column_default(:questions, :image, "")
  end
end