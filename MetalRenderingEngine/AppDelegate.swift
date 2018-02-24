//
//  AppDelegate.swift
//  Solar System
//
//  Created by Gaurav Sharma on 25/05/17.
//  Copyright (c) 2017 Godrej Innovation Center. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        window.acceptsMouseMovedEvents = true //now window will recieve mouse move events
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}
