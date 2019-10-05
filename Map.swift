class Map {
    var room: Int;
    var backup: Int
    var shouldmoveup: Bool = false
    var shouldmovedown: Bool = false
    var play: Bool = true
    var ThePlayer: Player
    var unsavedPlayer: Player 

    init(player: Player) {
        room=3
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
        playAmbientMusic()
        while(play) {
            runRoom()
        }
        stopAmbientMusic()
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
                print("1. Destroy: Destroy the fountain\n2. Search: Search the room\n3. Open: Attempt to open the door")
            }else {
                print("1. Jump: Jump into the hole\n2. Search: Search the room\n3. Open: Attempt to open the door")
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

        if((s.lowercased()=="destroy" || s.lowercased()=="1") && !action4room1) {
            return Room1Actions.Destroy
        }else if(s.lowercased()=="search" || s.lowercased()=="2") {
            return Room1Actions.Search
        }else if(s.lowercased()=="open" || s.lowercased()=="3") {
            return Room1Actions.Open
        }else if((s.lowercased()=="jump" || s.lowercased()=="1") && action4room1){
            return Room1Actions.Jump
        }
        print("Please input a valid action")
        return room1ActionsGet()
    }


    enum Room2Actions {
        case Search
        case LeftDoor
        case MiddleDoor
        case RightDoor
        case TrapDoor
    }

    var enter2 = true
    var skeleton: Enemy = Enemy(nameIn: "Skeleton")
    var skeletonalive = true
    var fight1: Fight = Fight()
    var isldoorskeldeadonce = false
    func room2() {
        if(enter2) {
            print("You enter a room through the hole. Cool.")
            shouldmoveup=false;
            enter2=false
            print("You land on a pile of bones, and are suddenly flung back. The bones reform into a skeleton.")
            print("FIIIGHT!")
            skeleton.levelUp()
            fight1 = Fight(enemyIn: skeleton, playerIn: ThePlayer)
            ThePlayer = fight1.getPlayer()
            if(fight1.playerWon()) {
                skeletonalive = false
                print("As you get a better look around the room, you see that there are traces of skeletons,\nbut they seem to have been destroyed by something, or someone.")
                print("This room is much larger than the one you were in before. It has marble columns and archways\noverhead. This was built by advanced architects...")
                print("There is a door off to your left, one off to your right, and one down the middle")
            }else{
                print("game over...")
                game_over()
            }
        }

        if(!skeletonalive) {
            if(game_tick()==GameTickEnum.ractions) {
                print("Options:")
                print(" 1. Search: Search the room")
                print(" 2. OpenL: Open the left door")
                print(" 3. OpenM: Open the middle door")
                print(" 4. OpenR: Open the right door")
                if(isldoorskeldeadonce) {
                    print(" 5. OpenT: Open the trapdoor")
                }
                let action = Room2ActionsGet()

                switch(action){
                    case Room2Actions.Search:
                        print("As you search the room you find a book and open it. It says that if the doors are\nopened in a certain order, treasure awaits. Then, there seem to be exceedingly complicated instructions\nabout how to obtain this treasure after getting the door sequence correct.\n\nDo you wish to read the book?")
                        let yn=readBookRoom2()
                        if(yn=="y"){
                            let dotdotdot = "......................................................................"
                            print(dotdotdot)
                            print(dotdotdot)
                            print(dotdotdot)
                            print(dotdotdot)
                            print("You FINALLY get to the last page of the book, which has only a few words on it. It says, \"CONGRATULATIONS! You, yes YOU,\n just wasted hours of your time, reading a useless piece of crap! That was a pretty\n stupid thing to do, yknow.\"")
                            print("Well aren't you a GENIUS.")
                        }else{
                            print("As you set the book down, you get the feeling that reading it wouldn't have been a good idea anyway.")
                        }
                    break

                    case Room2Actions.LeftDoor:
                        print("You open the left door, and notice another skeleton at the end of the room. Before you\ncan do anything, it notices you and charges you.")
                        print("FIIIIGHT!")
                        skeleton.reset()
                        fight1 = Fight(enemyIn: skeleton, playerIn: ThePlayer)
                        ThePlayer = fight1.getPlayer()
                        if(fight1.playerWon()) {
                            if(!isldoorskeldeadonce){
                                print("You leave the room, and notice a trapdoor in the floor that wasn't there before...")
                            isldoorskeldeadonce=true
                            }else {
                                print("You leave the room. Nothing happens, what were you expecting?")
                            }
                        }else{
                            print("game over...")
                            game_over()
                        }
                    break

                    case Room2Actions.MiddleDoor:
                        print("You open the middle door, and walk inside a small room. You get your head nearly chopped off,\nand you run back outside.")
                    break

                    case Room2Actions.RightDoor:
                        print("You open the door, and fall to your death. Nice one, idot.")
                        game_over()
                    break

                    case Room2Actions.TrapDoor:
                    shouldmoveup=true
                    break
                }
            }
        }
    }

    func readBookRoom2() -> String {
        let s = string_unwrapper(str:inputForced())

        if(s.lowercased()=="yes") {
            return "y"
        }else if(s.lowercased()=="no"){
            return "n"
        }
        print("Please answer yes or no.")
        return readBookRoom2()
    }

    func Room2ActionsGet() -> Room2Actions {
        let s = string_unwrapper(str:inputForced())

        if(s.lowercased()=="search" || s.lowercased()=="1") {
            return Room2Actions.Search
        }else if(s.lowercased()=="OpenL" || s.lowercased()=="2") {
            return Room2Actions.LeftDoor
        }else if(s.lowercased()=="OpenM" || s.lowercased()=="3") {
            return Room2Actions.MiddleDoor
        }else if(s.lowercased()=="OpenR" || s.lowercased()=="4"){
            return Room2Actions.RightDoor
        }else if((s.lowercased()=="OpenT" || s.lowercased()=="5") && isldoorskeldeadonce){
            return Room2Actions.TrapDoor
        }
        print("Please input a valid action")
        return Room2ActionsGet()
    }

    var canescape = false
    var enter3=true
    func room3() {
        if(enter3) {
            print("You fall down, after a long 20 seconds of falling, you hit the ground and lose consciousness.")
            print("When you wake up, you notice that you are in a small jail cell.")
            print("Looking to your left, you notice that there is another very sketchy looking person being held captive in an adjacent cell.")
            print("The shady man turns to you and says, 'Hey kid. You want to help me get out of here?'")
            let gowithprisoner = goWithPrisoner()
            if(gowithprisoner==1) {
                print("You successfuly escape with him, but as you turn around he says, 'Die, I'm hungry.' He kills you before\nyou can react.")
                game_over()
            }else if(gowithprisoner==0){
                print("'Fine then, I'll do it alone! I was going to kill you anyways for food, but you'd\nprobably taste terrible anyways. Bye.'")
                print("He uses a rock he had on him to bash the lock in, but as he is walking down the hall,")
                print("you notice a bow sticking out of the wall behind him. He is shot in the neck by a skeleton,\n and dies immediatly from the poison coating")
                print("The skeleton looks at you, and says, 'Don't even think about escaping, or you'll end up like him.'")
                print("The skeleton leaves the hallway.")
            }
            shouldmoveup=false
            enter3=false
        }else{
            if(game_tick()==GameTickEnum.ractions) {
                print("Options:")
                print("1. Search: Search the room")
                if(canescape) {
                    print("2. Escape: Crawl through the metal grate into the sewers.")
                }
                let action = Room3ActionsGet()

                if(action==Room3Actions.Search) {
                    S_Room3()
                }else if(action==Room3Actions.Escape) {
                    let action_s = E_Room3()
                }
            }
        }
    }

    enum Room3SearchActions {
        case SearchBGet
        case SearchTGet
        case SearchGGet
        case SearchBGotten
        case SearchTGotten
        case SearchGGotten
        case SearchTNotYet
        case SearchGNotYet
        case NOU
    }

    func S_Room3() {
        print("Options: ")
        print("1. SearchB: Search the Bookcase")
        print("2. SearchT: Search the Toilet")
        print("3. SearchG: Search the Metal Grate")
        let action = Room3SearchActionsGet()
        
        switch(action) {
            case Room3SearchActions.SearchBGet:
                print("You attempt to grab a book off of the bookshelf. You pull a book off of the third\nrow and notice a shiny metal object behind the books, it's a wrench!")
            break
            case Room3SearchActions.SearchTGet:
                print("You use the wrench to unscrew a pipe from the toilet. This could be used as a weapon.")
            break
            case Room3SearchActions.SearchGGet:
                print("You use the wrench to break the metal bars over the grate and it reveals a hole\ngoing into the sewers.")
            break
            case Room3SearchActions.SearchBGotten:
                print("It is a bookshelf, it has books. One is missing because you took it.")
            break
            case Room3SearchActions.SearchTGotten:
                print("It is a toilet, it has a seat. There is a pipe missing because you took it.")
            break
            case Room3SearchActions.SearchGGotten:
                print("There is a grate. It is missing metal bars because you broke them.")
            break
            case Room3SearchActions.SearchTNotYet:
                print("Why are you sticking you face near the toilet?")
            break
            case Room3SearchActions.SearchGNotYet:
                print("This grate has metal bars covering it, you will need something to get them off and something to fight with.")
            break
            case Room3SearchActions.NOU:
                print("No U. ")
            break
            default:
                print("Stop Exist.")
            break
        }
    }

    func E_Room3() {
        print("yeetus defeatus commit self deletus.")
    }

    enum Room3Actions {
        case Search
        case Escape
    }

    var haspliers = false
    var haspipe = false
    var opengrate = false

    func Room3SearchActionsGet() -> Room3SearchActions {
        let s = string_unwrapper(str:inputForced())

        if(s.lowercased()=="searchb" || s.lowercased()=="1"){
            if(haspliers) {
                return Room3SearchActions.SearchBGotten
            }else{
                haspliers=true
                return Room3SearchActions.SearchBGet
            }
        }else if(s.lowercased()=="searcht" || s.lowercased()=="2") {
            if(haspliers && !haspipe) {
                haspipe=true
                return Room3SearchActions.SearchTGet
            }else if(haspliers && haspipe) {
                return Room3SearchActions.SearchTGotten
            }else if(!haspliers) {
                return Room3SearchActions.SearchTNotYet
            }
        }else if(s.lowercased()=="searchg" || s.lowercased()=="3") {
            if(haspipe && !opengrate) {
                opengrate=true
                canescape=true
                return Room3SearchActions.SearchGGet
            }else if(haspipe && opengrate) {
                return Room3SearchActions.SearchGGotten
            }else if(!haspipe) {
                return Room3SearchActions.SearchGNotYet
            }
            return Room3SearchActions.NOU
        }

        print("Please input a valid action")
        return Room3SearchActionsGet()
    }

    func Room3ActionsGet() -> Room3Actions {
        let s = string_unwrapper(str:inputForced())

        if(s.lowercased()=="search" || s.lowercased()=="1") {
            return Room3Actions.Search
        }else if((s.lowercased()=="escape" || s.lowercased()=="2") && canescape) {
            return Room3Actions.Escape
        }

        print("Please input a valid action")
        return Room3ActionsGet()
    }


    var annoyman = 0;

    func goWithPrisoner() -> Int {
        let s = string_unwrapper(str:inputForced())
        
        if(s.lowercased()=="yes") {
            return 1
        }else if(s.lowercased()=="no"){
            return 0
        }

        switch(annoyman) {
            case 0:
                print("The prisoner says, 'Please give me a straight answer.'")
                annoyman=annoyman+1
            break
            case 1:
                print("The man says, 'Oh dear lord, you must have hit your head when you fell.'")
                annoyman=annoyman+1
            break
            case 2:
                print("The man says, 'You terrible terrible person, you have been messing with me the whole time. STOP IT, FOOL. I was going to kill you anyway...'")
                annoyman=annoyman+1
            break
            case 3:
                print("The man says, 'Please die.'")
                print("You die.")
                game_over()
                return -1
            default:
            break

        }   
        return goWithPrisoner()
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
            
        print("Options:\n   1. Room Actions\n   2. Quit\n   3. Stats")
    
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
            if(input.lowercased()=="room actions" || input.lowercased()=="1"){
                return GameTickEnum.ractions
            }else if(input.lowercased()=="quit" || input.lowercased()=="2"){
                return GameTickEnum.quit
            }else if(input.lowercased()=="stats" || input.lowercased()=="3"){
                return GameTickEnum.stats
            }
            print("Please input a valid action")
            return game_tick_internal(input: string_unwrapper(str:inputForced()))
        }
    }


    func game_over() {
        print("GAME_OVER")
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
        isldoorskeldeadonce = false

        //Room 3
        enter3 = true
        annoyman = 0
        haspipe = false
        haspliers = false
        opengrate = false
    }

}