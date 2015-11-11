class AddWinnerRefToBattles < ActiveRecord::Migration
  def change
    add_reference :battles, :winner, index: true
  end
end