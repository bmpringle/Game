import Foundation

class Game {
    var ThePlayer: Player = Player()
    var askLevel: Int = 1
    var TheMap: Map
 
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
        print("WARNING!!! IF YOU ^C the game, you will lose any progress you made since you last saved. Please use \"Save\" in the overworld to save.")
        //var first: Bool = true
        TheMap = Map(player: Player())
        print("Hello! For a new game, please type newgame. To continue a game, type continue.")
        
        if(newgame_or_continue(input: string_unwrapper(str:inputForced()))==NewGameEnum.NewGame){

        }else{
            ThePlayer.readData()
        }

        while(playing){ 
            TheMap = Map(player: ThePlayer)
            playing = TheMap.startMap()
            /**
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
            TheMap.updatePlayer(player: ThePlayer)
            first=false
            **/
        }
        ThePlayer.writeData()
    }

    func getPlayer() -> Player {
        return ThePlayer
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

let game = Game()

/**To-Do List
* 1. ADD GRAPHICS
* 2. Flavoring text for attacks and blocks
* 3. New types of attacks, revamp battle system
**/

