//
//  AppDelegate.swift
//  ClearSpotifyCache
//
//  Created by Tsuyoshi Ogasawara on 4/9/17.
//  Copyright © 2017 Tsuyoshi Ogasawara. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var menu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // set icon
        if let button = statusItem.button {
            //button.action = #selector(self.togglePopover)
            //button.action = Selector("togglePopover:")
            button.image = NSImage(named: "statusBarIcon")
        }else{
            self.statusItem.title = "Clear Cach"
        }
        
        self.statusItem.highlightMode = true
        self.statusItem.menu = menu
        
        // create cach clear menu and add
        let actionItem = NSMenuItem()
        actionItem.title = "Clear cache & launch"
        actionItem.action = #selector(AppDelegate.clearCash(_:))
        menu.addItem(actionItem)
        
        // create quit menu and add
        let quitItem = NSMenuItem()
        quitItem.title = "Quit"
        quitItem.action = #selector(AppDelegate.quit(_:))
        menu.addItem(quitItem)

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func quit(_ sender: Any){
        // quit app
        NSApplication.shared().terminate(self)
    }
    
    func clearCash(_ sender: Any){
        let obj = SpotifyCache()
        obj.deleteAllCash()
    }

}

