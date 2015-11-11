class AddProcessedToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :processed, :boolean
  end
end