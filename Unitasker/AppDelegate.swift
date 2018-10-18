//
//  AppDelegate.swift
//  Unitasker
//
//  Created by chee on 17/10/2018.
//  Copyright © 2018 snoots & co. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	var text = ""
	var timer: Timer?
	
	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
	let pop = NSPopover()

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		
		if let button = statusItem.button {
			button.image = NSImage(named: NSImage.Name("yoy"))
			button.action = #selector(togglePopover(_:))
		}

		pop.contentViewController = WhatAreYouDoingViewController.freshController()
	}
	
	func createNotification () -> NSUserNotification {
		let notification = NSUserNotification()
		
		notification.title = "currently working on"
		notification.informativeText = text
		notification.soundName = NSUserNotificationDefaultSoundName
		
		return notification
	}
	
	func sendNotification () {
		NSUserNotificationCenter.default.deliver(createNotification())
	}
	
	@objc func togglePopover(_ sender: Any?) {
		if pop.isShown {
			closePopover(sender: sender)
		} else {
			showPopover(sender: sender)
		}
	}
	
	func showPopover(sender: Any?) {
		if let timer = timer {
			timer.invalidate()
			self.timer = nil
		}
		if let button = statusItem.button {
			pop.show(
				relativeTo: button.bounds,
				of: button,
				preferredEdge: .minY
			)
		}
	}
	
	func closePopover(sender: Any?) {
		startTimer()
		pop.performClose(sender)
	}
	
	func startTimer() {
		if (text.isEmpty) {
			return
		}

		self.timer = Timer.scheduledTimer(withTimeInterval: 60 * 5, repeats: true) {
			print($0)
			self.sendNotification()
		}

		self.timer?.fire()
	}
	
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
}
