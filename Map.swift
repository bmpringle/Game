class Map {
    var room: Int;
    var backup: Int
    var shouldmoveup: Bool = false
    var shouldmovedown: Bool = false
    var play: Bool = true
    var ThePlayer: Player
    var unsavedPlayer: Player 

    init(player: Player) {
        room=1
        backup=room
        ThePlayer=player
        unsavedPlayer = player
    }

    enum GameTickEnum {
        case ractions
        case stats
        case quit
    }

    func updatePlayer(player: Player) {
        ThePlayer=player
    }

    func startMap() -> Bool{
        while(play) {
            runRoom()
        }
        return play
    }

    func runRoom() {
        if(shouldmoveup==true) {
            room=room+1
        }

        if(shouldmovedown==true) {
            room=room-1
        }

        if(shouldmovedown==true && shouldmoveup==true) {
            backup=room
            room = -1
        }

        switch(room) {
            case 1:
                room1()
            break
            case 2:
                room2()
            break
            case 3:
                room3()
            break
            case 4:
                room4()
            break
            case 5:
                room5()
            break
            case 6:
                room6()
            break
            case 7:
                room7()
            break
            case 8:
                room8()
            break
            default:
                roomNO()
            break;
        }
    }

    var fountaincrack = 0
    var fountaindestroyed = false
    var enter1 = true
    var action4room1 = false
    func room1() {
        if(enter1){
            shouldmoveup=false
            print("You walk into the room, and you see a fountain in the middle of the room. What do you do?")
            enter1=false
        }
        
        if(fountaindestroyed) {
            action4room1=true
        }

        if(game_tick()==GameTickEnum.ractions) {
            if(!action4room1) {
                print("Destroy the fountain\nSearch the room\nAttempt to open the door")
            }else {
                print("Jump into the hole\nSearch the room\nAttempt to open the door")
            }
            let action = room1ActionsGet()

            if(action==Room1Actions.Destroy) {
                if(fountaincrack==0) {
                    fountaincrack=1
                    print("You walk over to the fountain, and swing your fist at it. It cracks a bit")
                }else if(fountaincrack==1) {
                    fountaincrack=2
                    print("You walk over to the fountain, and swing your fist at it again with\nall your might. It cracks a bit more.")
                }else if(fountaincrack==2) {
                    print("You swing at the fountain with your fist one final time, and it \nbreaks apart revealing a hole.")
                    fountaindestroyed=true
                }
            }else if(action==Room1Actions.Search) {
                print("This room is completely bare, except for the fountain in the middle.")
            }else if(action==Room1Actions.Open) {
                print("What door, silly?")
            }else if(action==Room1Actions.Jump) {
                print("You jump into the hole.")
                shouldmoveup=true
            }
        }else {
            play=false
        }
    }

    enum Room1Actions {
        case Destroy
        case Search
        case Open
        case Jump
        case Nope
    }

    func room1ActionsGet() -> Room1Actions {
        let s = string_unwrapper(str:inputForced())

        if(s.lowercased()=="destroy") {
            return Room1Actions.Destroy
        }else if(s.lowercased()=="search") {
            return Room1Actions.Search
        }else if(s.lowercased()=="open") {
            return Room1Actions.Open
        }else if(s.lowercased()=="jump" && action4room1){
            return Room1Actions.Jump
        }
        print("Please input a valid action")
        return room1ActionsGet()
    }

    var enter2 = true
    var skeleton: Enemy = Enemy(nameIn: "Skeleton")
    var skeletonalive = true
    var fight1: Fight = Fight()
    func room2() {
        if(enter2) {
            print("You enter a room through the hole. Cool.")
            shouldmoveup=false;
            enter2=false
            print("You land on a pile of bones, and are suddenly flung back. The bones reform into a skeleton.")
            print("FIIIGHT!")
            fight1 = Fight(enemyIn: skeleton, playerIn: ThePlayer)
            ThePlayer = fight1.getPlayer()
            if(fight1.playerWon()) {
                skeletonalive = false
            }else{
                game_over()
            }
        }
    }

    func room3() {
        
    }

    func room4() {
        
    }

    func room5() {
        
    }

    func room6() {
        
    }

    func room7() {
        
    }

    func room8() {
        
    }

    func room9() {
        
    }

    func roomNO() {
        print("(*&^%$#@!@#$%^&*&^%$#@#$%^&*(*&^%$#@")
    }

    func game_tick() -> GameTickEnum{
            
        print("Options:\n   Room Actions\n   LEAVE\n   STATS")
    
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
        }
        print("THISISNOTPOSSIBLE")
        return GameTickEnum.ractions
    }

    func game_tick_internal(input: String) -> GameTickEnum{
        if(input == "nil"){
            print("Please give an input!")
            return game_tick_internal(input: string_unwrapper(str:inputForced()))
        }else{
            if(input.lowercased()=="room actions"){
                return GameTickEnum.ractions
            }else if(input.lowercased()=="leave"){
                return GameTickEnum.quit
            }else if(input.lowercased()=="stats"){
                return GameTickEnum.stats
            }
            print("Please input a valid action")
            return game_tick_internal(input: string_unwrapper(str:inputForced()))
        }
    }


    func game_over() {
        room=1
        backup=room
        ThePlayer=unsavedPlayer
        shouldmoveup = false
        shouldmovedown = false

        //Room 1
        fountaincrack = 0
        fountaindestroyed = false
        enter1 = true
        action4room1 = false

        //Room 2
        enter2 = true
        skeleton = Enemy(nameIn: "Skeleton")
        skeletonalive = true
    }

}