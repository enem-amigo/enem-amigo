module NotificationsHelper

  def new_battle_notification(battle)
    message = "#{current_user.name} convidou você para uma batalha"
    message += 'da categoria' + battle.category if battle.category != ""
    notification = Notification.create(message: message, user: battle.player_2, battle: battle)
    battle.player_2.notifications << notification
  end

  def battle_answer_notification(battle, answer)
    message = "#{current_user.name} "  + (answer ? "" : "não ") + "aceitou se convite para uma batalha"
    notification = Notification.create(message: message, user: battle.player_1, battle: battle)
    battle.player_1.notifications << notification
  end

end