import Foundation

class Move {
    var attack: DarwinBoolean
    var defence: DarwinBoolean
    var status: DarwinBoolean
    var name: String
    var type: String
    var mod: Double
    
    init(){
        attack=false
        defence=false
        status=false
        name="BLANK"
        type="none"
        mod=0.0
    }
    init(attackin: DarwinBoolean, defencein: DarwinBoolean, statusin: DarwinBoolean, namein: String, typein: String, modin: Double) {
        attack=attackin
        defence=defencein
        status=statusin
        name=namein
        type=typein
        mod=modin
    }

    func getType() -> String{
        return type
    }

    func getName() -> String{
        return name
    }

    func getAttack() -> DarwinBoolean{
        return attack
    }

    func getStatus() -> DarwinBoolean{
        return status
    }

    func getDefence() -> DarwinBoolean{
        return defence
    }

    func getMod() -> Double{
        return mod
    }
}

class Punch: Move{
    override init(){
        super.init(attackin: true, defencein: false, statusin: false, namein: "Punch", typein: "physical", modin:1.0)
    }   
}

class ArmBlock: Move{
    override init(){
        super.init(attackin: false, defencein: true, statusin: false, namein: "Arm Block", typein: "physical", modin:1.5)
    }   
}

class SpinKick: Move{
    override init(){
        super.init(attackin: true, defencein: false, statusin: false, namein: "Spin Kick", typein: "physical", modin: 1.3)
    }
}

class Intimidate: Move{
    override init(){
        super.init(attackin: false, defencein: false, statusin: true, namein: "Intimidate", typein: "status", modin: 0.7)
    }
}

class Fight {

    enum Winners {
        case player
        case enemy
        case nobody
    }

    var enemy: Enemy
    var player: Player
    var winner: Winners = Winners.nobody

    func getPlayer() -> Player{
        return player
    }
    init(enemyIn: Enemy, playerIn: Player) {
        enemy=enemyIn
        player=playerIn
        
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
            player.reset()
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
            print("The winner is the enemy...")
            player.reset()
        }
    }

    func process_move(move: Move, mover: Entity, otherentity: Entity){
        if(move.getAttack().boolValue) {
            otherentity.takedamage(damage: mover.attack(move: move))
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

class Game {
    var ThePlayer: Player = Player()
    var askLevel: Int = 1
    enum PlayEnum{
        case play
        case stats
        case quit
    }
    enum NewGameEnum {
        case NewGame
        case Continue
    }

    var playing = true
    init(){
        var first: Bool = true

        print("Hello! For a new game, please type newgame. To continue a game, type continue.")
        
        if(newgame_or_continue(input: string_unwrapper(str:inputForced()))==NewGameEnum.NewGame){

        }else{
            ThePlayer.readData()
        }
        while(playing){   
            process_playornot(first: first)
            if(playing==false){
                break;
            }
            print("What level enemy would you like to fight?")
            askLevel = enemy_level(str: string_unwrapper(str:inputForced()))

            //Level 1 Enemy: Heath 20, Offence 10, Defence 5
            //Level 1 Player: Heath 20, Offence 10, Defence 5, knows Punch and Arm Block
            let fight = Fight(enemyIn: createEnemy(level: askLevel), playerIn: ThePlayer)
            ThePlayer=fight.getPlayer()
            first=false
        }
        ThePlayer.writeData()
    }

    func process_playornot(first: Bool){
        if(first){
            print("Options:\n   FIGHT\n   LEAVE\n   STATS")
        }else{
            print("Options:\n   FIGHT\n   LEAVE\n   STATS")
        }
        let input = string_unwrapper(str:inputForced())
        let play = play_or_not(input: input)
        if(play == PlayEnum.quit){
            playing=false
            print("Bye!")
        }else if(play == PlayEnum.stats){
            print("Your stats are:")
            ThePlayer.printPlayerStats()
            process_playornot(first: first)
        }
    }
    func createEnemy(level: Int) -> Enemy{
        let new_enemy = Enemy()
        if(level==1){
            return new_enemy
        }
        for _ in 0...level-2{
           new_enemy.levelUp()
        }
        return new_enemy
    }

    func enemy_level(str: String) -> Int{
        if(str=="nil"){
            print("Please give an input!")
            return enemy_level(str: string_unwrapper(str:inputForced()))
        }else if let i = Int(str){
            if(i>0){
                return i
            }else{
                print("Please input a integer greater than 0")
            return enemy_level(str: string_unwrapper(str:inputForced()))
            }     
        }else{
            print("Please input a valid Integer")
            return enemy_level(str: string_unwrapper(str:inputForced()))
        }
    }
    func play_or_not(input: String) -> PlayEnum{
        if(input == "nil"){
            print("Please give an input!")
            return play_or_not(input: string_unwrapper(str:inputForced()))
        }else{
            if(input.lowercased()=="fight"){
                return PlayEnum.play
            }else if(input.lowercased()=="leave"){
                return PlayEnum.quit
            }else if(input.lowercased()=="stats"){
                return PlayEnum.stats
            }
            print("Please input a valid action")
            return play_or_not(input: string_unwrapper(str:inputForced()))
        }
    }

    func newgame_or_continue(input: String) -> NewGameEnum{
        if(input == "nil"){
            print("Please give an input!")
            return newgame_or_continue(input: string_unwrapper(str:inputForced()))
        }else{
            if(input=="newgame"){
                return NewGameEnum.NewGame
            }else if(input=="continue"){
                return NewGameEnum.Continue
            }
            print("Please input a valid action")
            return newgame_or_continue(input: string_unwrapper(str:inputForced()))
        }
    }
}

func inputForced() -> String? {
    return readLine()
}

func string_unwrapper(str: String?) -> String{
        if let ustr=str {
            return ustr
        }else {
            return "nil"
        }
}

func writeFile(path: String, towrite: NSString) {
    do {
        try  towrite.write(toFile: path, atomically:false, encoding: String.Encoding.utf8.rawValue)
    }
    catch let error as NSError {
        print("ERROR ERROR ABOOOOOOOORT!!!!!!!: \(error).")
    }
}

func readFile(path: String) -> String{
    do {
        // Get the contents
        let contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) 
        return contents as String
    }
    catch let error as NSError {
        print("ERROR ERROR ABOOOOOOOORT!!!!!!!: \(error).")
        return "nil"
    }
}

let game = Game()

/**To-Do List
* 1. ADD GRAPHICS
* 2. Flavoring text for attacks and blocks
* 3. New types of attacks, revamp battle system
**/

