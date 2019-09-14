import Foundation

class Move {
    var attack: DarwinBoolean
    var defence: DarwinBoolean
    var name: String
    var type: String
    var mod: Double
    
    init(){
        attack=false
        defence=false
        name="BLANK"
        type="none"
        mod=0.0
    }
    init(attackin: DarwinBoolean, defencein: DarwinBoolean, namein: String, typein: String, modin: Double) {
        attack=attackin
        defence=defencein
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

    func getDefence() -> DarwinBoolean{
        return defence
    }

    func getMod() -> Double{
        return mod
    }
}

class Punch: Move{
    override init(){
        super.init(attackin: true, defencein: false, namein: "Punch", typein: "physical", modin:1.0)
    }   
}

class ArmBlock: Move{
    override init(){
        super.init(attackin: false, defencein: true, namein: "Arm Block", typein: "physical", modin:1.5)
    }   
}

class SpinKick: Move{
    override init(){
        super.init(attackin: true, defencein: false, namein: "Spin Kick", typein: "physical", modin: 1.3)
    }
}

class Player {
    var maxHealth = 20
    var health: Int
    var offence = 10
    var defence = 5
    var moveDefence: Int
    var moveOffence: Int
    var exp = 0
    var level = 1;
    var isAlive = true
    var xpToLevelUp: Int
    var move1: Move = Punch()
    var move2: Move = ArmBlock()
    var move3: Move = Move()
    var move4: Move = Move()

    func moves_string() -> String{
        return "\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())"
    }
    func writeData(){
        let datatowrite = NSString(string: "\(level)\n\(maxHealth)\n\(offence)\n\(defence)\n\(exp)\n\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())")
        writeFile(path: "Data/playerdata.data", towrite: datatowrite)
    }

    func readData(){
        let playerdata = readFile(path: "Data/playerdata.data")
        var lines = playerdata.split { $0.isNewline }
        level = Int(String(lines[0]))!
        maxHealth = Int(String(lines[1]))!
        health = maxHealth
        offence = Int(String(lines[2]))!
        defence = Int(String(lines[3]))!
        moveOffence = offence
        moveDefence = defence
        exp = Int(String(lines[4]))!
        move1 = match_string_to_move(str: String(lines[5]))
        move2 = match_string_to_move(str: String(lines[6]))
        move3 = match_string_to_move(str: String(lines[7]))
        move4 = match_string_to_move(str: String(lines[8]))
        xpToLevelUp = level*level
    }

    func match_string_to_move(str: String) -> Move{
        switch(str){
            case Punch().getName():
            return Punch()

            case ArmBlock().getName():
            return ArmBlock()

            case SpinKick().getName():
            return SpinKick()

            default:
            return Move()
        }
    }

    func getXP() -> Int{
        return exp
    }

    func printPlayerStats() {
        print("You are level \(level)")
        print("Max health is \(maxHealth)")
        print("Offence is \(offence)")
        print("Defence is \(defence)")
        print("You have \(exp) xp, and you need \(xpToLevelUp) xp to level up")
        print("Your moves are:\n\(move1.getName())\n\(move2.getName())\n\(move3.getName())\n\(move4.getName())")
    }
    func getXPToLevelUp() -> Int {
        return xpToLevelUp
    }

    func setXP(xpIn: Int) {
        exp=xpIn
    }
    init() {
        health = maxHealth
        xpToLevelUp=1
        moveDefence=defence
        moveOffence=offence
    }

    func reset(){
        isAlive = true
        health = maxHealth
        moveOffence=offence
        moveDefence=defence
    }

    init(healthIn: Int, offenceIn: Int, defenceIn: Int) {
        maxHealth=healthIn
        health=healthIn
        offence=offenceIn
        defence=defenceIn
        xpToLevelUp = level*level
        moveOffence=offence
        moveDefence=defence
    }

    func attack(move: Move) -> Int {
        moveOffence=Int(Double(offence)*move.getMod())
        let crit = Int.random(in: 0 ... 1)
        if crit == 1 {
            let damage = (moveOffence*3)/2
            print("You get a critical hit!")
            print("You use \(move.getName()) and do \(damage) damage to the enemy.")
            return damage
        }else{
            print("You use \(move.getName()) and do \(moveOffence) damage to the enemy.")
            return moveOffence
        }
    }

    func alive() -> Bool {
        return isAlive
    }

    func levelUp() {
        print("You Leveled Up!")
        offence=offence+1
        defence=defence+1
        maxHealth=maxHealth+5
        health=maxHealth
        exp=0
        if(Float(level)/2.0==Float(level/2)){
            offence=offence+2
        }else if(Float(level)/3.0==Float(level/3)){
            defence=defence+1
        }else{
            maxHealth=maxHealth+5
        }
        level=level+1
        xpToLevelUp = level*level  
        health=maxHealth     
    }

    func block(move: Move) {
        moveDefence=Int(Double(defence)*move.getMod())
        print("You use \(move.getName())")
    }

    func takedamage(damage: Int) {
        if(health>=damage){
            if((damage>moveDefence/2)){
                let takendamage = (damage)-moveDefence/2
                print("You take \(takendamage) damage. You have \(health-takendamage) heath left.")
                health=health-takendamage
            }
        }else{
            health=0
        }
        if(health==0){
            isAlive=false
        }
    }

    func resetDefence() {
        moveDefence = defence
    }
}

class Enemy {
    var health = 20
    var offence = 10
    var defence = 5
    var isAlive = true
    var isBlocking = false
    var level = 1
    init() {

    }
    
    func getLevel() -> Int{
        return level
    }

    init(healthIn: Int, offenceIn: Int, defenceIn: Int) {
        health=healthIn
        offence=offenceIn
        defence=defenceIn
    }

    func levelUp() {
        offence=offence+1
        defence=defence+1
        health=health+5
        if(Float(level)/2.0==Float(level/2)){
            offence=offence+2
        }else if(Float(level)/3.0==Float(level/3)){
            defence=defence+1
        }else{
            health=health+5
        }
        level=level+1       
    }

    func attack() -> Int {
        let crit = Int.random(in: 0 ... 1)
        if crit == 1 {
            let damage = (offence*3)/2
            print("The enemy crits!")
            print("The enemy deals \(damage) damage to you.")
            return damage
        }else{
            print("The enemy deals \(offence) damage to you.")
            return offence
        }
    }

    func alive() -> Bool {
        return isAlive
    }

    func block() {
        isBlocking=true
        print("The enemy blocks.")
    }

    func takedamage(damage: Int) {
        if(isBlocking==true){
            if(health>=(damage)/2){
                if((damage/2>defence/2)){
                    let takendamage = (damage)/2-defence/2
                    print("The enemy takes \(takendamage) damage. The enemy has \(health-takendamage) heath left.")
                    health=health-takendamage
                }
            }else{
                health=0
            }
            if(health==0){
                isAlive=false
            }
        }else{
            if(health>=damage){
                if((damage/2>defence/2)){
                    let takendamage = (damage)-defence/2
                    print("The enemy takes \(takendamage) damage. The enemy has \(health-takendamage) heath left.")
                    health=health-takendamage
                }
            }else{
                health=0
            }
            if(health==0){
                isAlive=false
            }
        }
        isBlocking=false
    }
}

class Fight {
    enum FightAction {
        case attack
        case block
        case impossible
    }
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
            process_player_move(move: player_turn())
            
            if(!player.alive() || !enemy.alive()){
                break
            }
            process_enemy_move(action: enemy_turn())
            player.resetDefence()
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

    func process_enemy_move(action: FightAction){
        if(action == FightAction.attack){
            player.takedamage(damage: enemy.attack())
        }else if(action == FightAction.block){
            enemy.block()
        }
    }

    func process_player_move(move: Move){
        if(move.getAttack().boolValue) {
            enemy.takedamage(damage: player.attack(move: move))
        }else if(move.getDefence().boolValue) {
            player.block(move: move)
        }
    }

    func enemy_turn() -> FightAction{
        let fight = Int.random(in: 0 ... 1)
        if(fight==0){
            return FightAction.attack
        }else{
            return FightAction.block
        }
    }

    func player_turn() -> Move{
        print("What move do you want to use?\n\(player.moves_string())")
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
            print("To fight, answer yes, to leave, answer no. To check stats, ask for stats.")
        }else{
        print("Do you want to fight again? Answer yes or no. If you want to view your stats, ask for stats.")
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
            if(input=="yes"){
                return PlayEnum.play
            }else if(input=="no"){
                return PlayEnum.quit
            }else if(input=="stats"){
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
*/