//
//  WhatAreYouDoingViewController.swift
//  Unitasker
//
//  Created by chee on 18/10/2018.
//  Copyright © 2018 snoots & co. All rights reserved.
//

import Cocoa

class WhatAreYouDoingViewController: NSViewController, NSTextFieldDelegate {
	@IBOutlet weak var whatareyoudoingfield: NSTextField!
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		
		whatareyoudoingfield.delegate = self
		
		if let app = NSApplication.shared.delegate as? AppDelegate {
			whatareyoudoingfield.stringValue = app.text
		}
    }

	func controlTextDidEndEditing(_ obj: Notification) {
		if let movement = obj.userInfo!["NSTextMovement"] as? Int {
			if movement == NSReturnTextMovement {
				if let app = NSApplication.shared.delegate as? AppDelegate {
					app.text = whatareyoudoingfield.stringValue
					app.closePopover(sender: nil)
				}
			}
		}
	}
    
}

extension WhatAreYouDoingViewController {
	static func freshController() -> WhatAreYouDoingViewController {
		let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		let identifier = NSStoryboard.SceneIdentifier("WhatAreYouDoingViewController")
		guard let controller = storyboard.instantiateController(withIdentifier: identifier) as? WhatAreYouDoingViewController else {
			fatalError("where is my boi")
		}
		return controller
	}
}
