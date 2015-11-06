module NotificationsHelper

  def new_battle_notification(battle)
    message = "#{current_user.name} convidou você para uma batalha" + battle.category
    notification = Notification.create(message: message, user: battle.player_2)
    battle.player_2.notifications << notification
  end

  def battle_answer_notification(battle)
    message = "#{current_user.name} "  + battle.answer ? "" : "não " + "aceitou se convite para uma batalha"
    notification = Notification.create(message: message, user: battle.player_1)
    battle.player_1.notifications << notification
  end

end