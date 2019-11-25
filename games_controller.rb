
require './message_dialog'

class GamesController
  include MessageDialog

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  def battle(**params)
    build_characters(params)

    loop do
      @brave.attack(@monster)
      break if buttle_end?
      @monster.attack(@brave)
      break if buttle_end?
    end

    battle_judgment
  end

  private

    def build_characters(**params)
      @brave = params[:brave]
      @monster = params[:monster]
    end

    def buttle_end?
      @brave.hp <= 0 || @monster.hp <= 0
    end

    def brave_win?
      @brave.hp > 0
    end

    def battle_judgment
      result = calculate_of_exp_and_gold

      end_message(result)
    end

    def calculate_of_exp_and_gold
      if brave_win?
        brave_win_flag = true
        exp = (@monster.offense + @monster.defense) * EXP_CONSTANT
        gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT
      else
        brave_win_flag = false
        exp = 0
        gold = 0
      end
      {brave_win_flag: brave_win_flag, exp: exp, gold: gold}
    end
end
