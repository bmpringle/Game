default:game

game : main.swift 
	swiftc Player.swift Entity.swift Enemy.swift Fight.swift Move.swift  GeneralFunctions.swift Map.swift $< -o $@
	install_name_tool -add_rpath "/usr/lib/swift" $@
	#install_name_tool -add_rpath "./Data/swiftlibs" $@ 
	#install_name_tool -change /usr/lib/swift/libswiftCore.dylib @rpath/libswiftCore.dylib game
	#install_name_tool -change /usr/lib/swift/libswiftDarwin.dylib @rpath/libswiftDarwin.dylib game
	#install_name_tool -change /usr/lib/swift/libswiftFoundation.dylib @rpath/libswiftFoundation.dylib game
	#install_name_tool -change /usr/lib/swift/libswiftObjectiveC.dylib @rpath/libswiftObjectiveC.dylib game
	#This shouldn't be necissary, but Catalina is broken
clean:
	rm ./game
