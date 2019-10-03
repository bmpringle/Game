default:game

game : main.swift 
	swiftc Player.swift Entity.swift Enemy.swift Fight.swift Move.swift  GeneralFunctions.swift Map.swift $< -o $@
	install_name_tool -add_rpath "/usr/lib/swift" $@ 
	#This shouldn't be necissary, but Catalina is broken
clean:
	rm ./game
