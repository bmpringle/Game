class Map {
    var room: Int;
    var backup: Int
    var shouldmoveup: Bool = false
    var shouldmovedown: Bool = false
    var play: Bool = true
    var ThePlayer: Player
    var unsavedPlayer: Player 
    var finished = false

    init(player: Player) {
        room=1
        backup=room
        ThePlayer=player
        unsavedPlayer = player
    }

    enum GameTickEnum {
        case ractions
        case items
        case stats
        case quit
    }

    func updatePlayer(player: Player) {
        ThePlayer=player
    }

    func startMap() -> Bool{
        playAmbientMusic()
        while(play && !finished) {
            runRoom()
        }
        stopAmbientMusic()
        return play
    }

    func runRoom() {
        
    }

    func returnPlayer() -> Player {
        return ThePlayer
    }

    func game_tick() -> GameTickEnum{
            
        print("Options:\n   1. Room Actions\n   2. Quit\n   3. Stats\n   4. Items")
    
        let input = string_unwrapper(str:inputForced())
        let action = game_tick_internal(input: input)
        
        if(action == GameTickEnum.quit){
            play=false
            print("Bye!")
            return GameTickEnum.quit
        }else if(action == GameTickEnum.stats){
            print("Your stats are:")
            ThePlayer.printPlayerStats()
            return game_tick()
        }else if(action == GameTickEnum.ractions) {
            return GameTickEnum.ractions
        }else if(action == GameTickEnum.items) {
            ThePlayer.displayItems()
            ThePlayer.useItem(name: string_unwrapper(str:inputForced()))
            return game_tick()
        }
        print("THISISNOTPOSSIBLE")
        return GameTickEnum.ractions
    }

    func game_tick_internal(input: String) -> GameTickEnum{
        if(input == "nil"){
            print("Please give an input!")
            return game_tick_internal(input: string_unwrapper(str:inputForced()))
        }else{
            if(input.lowercased()=="room actions" || input.lowercased()=="1"){
                return GameTickEnum.ractions
            }else if(input.lowercased()=="quit" || input.lowercased()=="2"){
                return GameTickEnum.quit
            }else if(input.lowercased()=="stats" || input.lowercased()=="3"){
                return GameTickEnum.stats
            }else if(input.lowercased()=="items" || input.lowercased()=="4") {
                return GameTickEnum.items
            }
            print("Please input a valid action")
            return game_tick_internal(input: string_unwrapper(str:inputForced()))
        }
    }
}
