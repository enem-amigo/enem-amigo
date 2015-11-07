class AddUserRefToBattles < ActiveRecord::Migration
  def change
    add_reference :battles, :player_1, index: true
    add_reference :battles, :player_2, index: true
  end
end