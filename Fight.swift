class Fight {

    enum Winners {
        case player
        case enemy
        case nobody
    }

    var enemy: Enemy
    var player: Player
    var winner: Winners = Winners.nobody
    var healafterbattle = false

    func playerWon() -> Bool {
        if(winner==Winners.player) {
            return true
        }else {
            return false
        }
    }

    func getPlayer() -> Player{
        return player
    }

    init() {
        //Does nothing
        enemy = Enemy()
        player = Player()
    }

    init(enemyIn: Enemy, playerIn: Player, heal: Bool) {
        healafterbattle=heal

        stopAmbientMusic()
        playNormalBattleMusic()

        enemy=enemyIn
        player=playerIn
        
        fight()

        stopNormalBattleMusic()
        playAmbientMusic()
    }

    init(enemyIn: Enemy, playerIn: Player) {
        stopAmbientMusic()
        playNormalBattleMusic()

        enemy=enemyIn
        player=playerIn
        
        fight()

        stopNormalBattleMusic()
        playAmbientMusic()
    }

    func fight() {
        while(player.alive() && enemy.alive()){
            process_move(move: player_turn(), mover: player, otherentity:enemy)
            enemy.resetTurn()
            if(!player.alive() || !enemy.alive()){
                break
            }
            process_move(move: enemy_turn(), mover: enemy, otherentity:player)
            player.resetTurn()
        }

        if(player.alive()){
            winner=Winners.player
            print("The winner is the player!")
            player.reset(shouldHeal: healafterbattle)
            let xpgained = enemy.getLevel()
            print("You got \(xpgained) xp!")
            if(player.getXP()+xpgained>=player.getXPToLevelUp()){
                let prevxptolvlup = player.getXPToLevelUp()
                let oxp = player.getXP()
                player.levelUp()
                player.setXP(xpIn:(oxp+xpgained)-prevxptolvlup)
            }else{
                player.setXP(xpIn: player.getXP()+enemy.getLevel())
            }
        }else{
            winner=Winners.enemy
            print("The winner is \(enemy.getName())...")
            player.reset()
        }
    }

    func process_move(move: Move, mover: Entity, otherentity: Entity){
        if(move.getAttack().boolValue) {
            otherentity.takedamage(damage: mover.attack(move: move, enemy: otherentity))
        }else if(move.getDefence().boolValue) {
            mover.block(move: move)
        }else if(move.getStatus().boolValue){
            otherentity.intimidated(mod: move.getMod())
        }
    }

    func enemy_turn() -> Move{
        let fight = Int.random(in: 0 ... enemy.moveamnt-1)
        switch(fight) {
            case 0:
                return enemy.move1
            case 1:
                return enemy.move2
            case 2:
                return enemy.move3
            case 3:
                return enemy.move4

            default:
                print("IMPOSSIBLE")
                return Move()
        }
    }

    func player_turn() -> Move{
        print("What move do you want to use?\n" + player.moves_string())
        let input = string_unwrapper(str:inputForced())
        if(input == "nil"){
            print("Please give an input!")
            return player_turn()
        }else{
            let move = player.match_string_to_move(str: input)
            if(move.getName() == "BLANK"){
                print("Please give a valid move!")
                return player_turn()
            }else{
                return move
            }
        }
    }
}