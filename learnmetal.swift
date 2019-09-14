import Cocoa
import AppKit
import Foundation

class MYViewController: NSViewController{
    init(){
        super.init(nibName:nil, bundle:nil)
    }

    required init(coder: NSCoder){
        super.init?(coder: coder)
    }
}

class learnmetal {
    var window: NSWindow
    var viewController: MYViewController


    init() {
        viewController = MYViewController()
        window = NSWindow(contentViewController: viewController)
    }
}

learnmetal()