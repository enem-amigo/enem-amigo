class Medal < ActiveRecord::Base

  serialize :achieved_instructions, Array
  serialize :percentage_instructions, Array

  def percentage
    self.percentage_instructions.each do |instruction|
      eval instruction
    end
  end

  def achieved
    self.achieved_instructions.each do |instruction|
      eval instruction
    end
  end

  #before_save { self.email = email.downcase }

end