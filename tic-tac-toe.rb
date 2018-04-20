class BoardCase
  attr_accessor :value, :position
  # Dans la classe Boardcase, on créer la méthode initialize qui attribut à chaque instance de la classe une valeur et une position
  def initialize(value, position)
    @value = value
    @position = position
  end
end

class Board
 attr_accessor :board
  # Dans la classe Board, on créer 9 nouvelles instances de la classe Boardcase pour constituer le plateau de jeu
  def initialize
    @case_1 = BoardCase.new(" ","A1")
    @case_2 = BoardCase.new(" ","A2")
    @case_3 = BoardCase.new(" ","A3")
    @case_4 = BoardCase.new(" ","B1")
    @case_5 = BoardCase.new(" ","B2")
    @case_6 = BoardCase.new(" ","B3")
    @case_7 = BoardCase.new(" ","C1")
    @case_8 = BoardCase.new(" ","C2")
    @case_9 = BoardCase.new(" ","C3")
    # On mets ces instances dans un array
    @board = []
    @board.push(@case_1,@case_2,@case_3,@case_4,@case_5,@case_6,@case_7,@case_8,@case_9)
  end

  # On créer la méthode d'affichage du board sur le terminal
  def display_board
    print "\n"
    puts "    TicTacToe"
    print "\n"
    puts "    1   2   3"
    print "\n"
    puts "A   #{@board[0].value} | #{@board[1].value} | #{@board[2].value} "
    puts "   ------------"
    puts "B   #{@board[3].value} | #{@board[4].value} | #{@board[5].value} "  
    puts "   ------------"
    puts "C   #{@board[6].value} | #{@board[7].value} | #{@board[8].value} "
    print "\n"
  end 
  # La méthode play permet de changer les valeur des boardcases selon le choix des joueurs
  def play(players_choices)
    ObjectSpace.each_object(BoardCase) do  |boardcase|
      ObjectSpace.each_object(Player) do |player|   
        # On appel les instances des classes player et boardcase
        players_choices.each do |hashturn|
          hashturn.each_pair do |playername, position|
            if boardcase.value == " "
              if boardcase.position == position && player.name == playername.to_s
                boardcase.value = player.value
                # pour chaque élément, on contrôle la position du boardcase et le nom du player puis on modifie la valeur du boardcase selon la valeur du joueur
              end
            end
          end
        end
      end
    end 
  end
  
  # Dans la méthode victory, on définit les les combinaisons de victoires
  def victory

    case
      when @case_1.value == @case_2.value && @case_1.value == @case_3.value && @case_1.value != " " && @case_2.value != " " && @case_3.value != " "
        return true
      when @case_4.value == @case_5.value && @case_4.value == @case_6.value && @case_4.value != " " && @case_5.value != " " && @case_6.value != " "
        return true
      when @case_7.value == @case_8.value && @case_7.value == @case_9.value && @case_7.value != " " && @case_8.value != " " && @case_9.value != " "
        return true
      when @case_1.value == @case_4.value && @case_1.value == @case_7.value && @case_1.value != " " && @case_4.value != " " && @case_7.value != " "
        return true
      when @case_2.value == @case_5.value && @case_2.value == @case_8.value && @case_2.value != " " && @case_5.value != " " && @case_8.value != " "
        return true
      when @case_3.value == @case_6.value && @case_3.value == @case_9.value && @case_3.value != " " && @case_6.value != " " && @case_9.value != " "
        return true
      when @case_1.value == @case_5.value && @case_1.value == @case_9.value && @case_1.value != " " && @case_5.value != " " && @case_9.value != " "
        return true
      when @case_3.value == @case_5.value && @case_3.value == @case_7.value && @case_3.value != " " && @case_5.value != " " && @case_5.value != " "
        return true
      else
        return false
    end
  end
end


class Player
  attr_accessor :name, :value, :win
  # Dans la classe Play, on créer la méthode initialize qui attribut à chaque instance de la classe ses paramètres (nom, valeur et statut)
  def initialize
    win = false
    @win = win
    choices = []
    # On demande au joueur de donner son nom et son symbole (qui peut seulement etre X ou O)
    puts "Nom du joueur : "
    name = gets.chomp
    @name = name
    puts "X ou O ? "
    value = gets.chomp
    if value == "X" || value == "O"
      @value = value
    else 
      puts "Ce n'est pas un symbole valide, X ou O ?"
      value = gets.chomp
      @value = value
    end
  end
end

class Game
  # Dans la classe game, on créer la méthode initialize qui permet de créer les instances des classes Player et board à chaque nouvelle partie
  attr_accessor :player_1, :player_2, :board
  def initialize
    print "\n"
    puts "This is my TicTacToe game made with Ruby!"
    print "\n"    
    @player_1 = Player.new
    @player_2 = Player.new
    @board = Board.new
    @players = []
    @players.push(@player_1, @player_2)
  end

  def go
    # Ici, on lance le jeu avec les règles et le premier tour
    puts "Prêts pour une partie?"
    puts "1. Soyez attentifs, si vous choisissez une case déjà prise, vous devrez sauter votre tour!"
    puts "2. Pour choisir une case, il faut croiser lettre et chiffre. ex : A1, B2, etc. "
    sleep 8
    self.turn
  end

  def turn 
    i = 0
    @players_choices = []
    # Il y a au maximum 9 tour, donc on continu dans que i est inf. à 9
    while i < 9 
      @players.each do |player|
        if i == 0 
          puts "C'est parti pour le premier tour, que le meilleur gagne :) ! "
        end
        @board.display_board
        # Pour chaque tour, on affiche le board, on adresse un message au joueur lui demandant où placer son pion
        puts "#{player.name}, ton symbole est : #{player.value} . Dans quelle case souhaites-tu jouer ? (ex: A1, B2, etc.)"
        choix = gets.chomp.to_s    
        unless choix == "A1" || choix == "A2" || choix == "A3" || choix == "B1" || choix == "B2" || choix == "B3" || choix == "C1" || choix == "C2" || choix == "C3"
          puts "cette case n'existe pas, une autre ?"
          choix = gets.chomp.to_s 
        end
        hash = Hash[player.name, choix ]
        # On enregistre dans un hash son nom et son choix avant de pusher ça dans un array
        @players_choices.push(hash)
        @board.play(@players_choices)
        # On appel la méthode play
        if @board.victory == true
          puts "--------------------- "
          puts "  #{player.name} You win, YAY!"
          puts "--------------------- "
          player.win = true
          break
          # On stop le jeu si l'une des conditions de victoire est remplie et on affiche le joueur qui a gagné 
        end
        i += 1
        if i == 9 
          puts "   ------------ "
          puts "+++++Match nul!+++++ "
          puts "   ------------ "
          self.end_game
          break 
          # On stop le jeu si on arrive à 9 tour sans victoire et on renvoi vers la méthode end_game
        end       
      end 
      if @board.victory == true
        self.end_game
        break  
        # On stop la boucle while en cas de victoire et on renvoi vers la méthode end_game             
      end         
    end           
  end

  def end_game 
    @board.display_board
    puts " -- Fin du jeu -- "
    puts "Try again ? y/n"
    new_game = gets.chomp
    if new_game == "y"
      Game.new.go
    else 
      puts "Come back later if you want!"
    end
    # La méthode end_game est appelée à la fin de chaque partie pour en proposer une autre
  end
end

Game.new.go