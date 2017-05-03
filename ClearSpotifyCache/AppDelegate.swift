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
    let loginItemMenu = NSMenuItem()
    var appname:String = "Clear Spotify Cache"

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // set appname
        if let value = NSRunningApplication.current().localizedName {
            self.appname = value
        }
        
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
        actionItem.title = "Clear cache"
        actionItem.action = #selector(AppDelegate.clearCash(_:))
        menu.addItem(actionItem)

        // create quit menu and add
        let obj = LoginItem()
        if( !obj.exist(name: self.appname) ) {
            self.loginItemMenu.title = "Add login item"
            self.loginItemMenu.action = #selector(AppDelegate.editLoginItem(_:))
            menu.addItem(self.loginItemMenu)
        }else{
            //self.loginItemMenu.title = "Delete login item"
        }
        
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
    
    func editLoginItem(_ sender: Any){
        let obj = LoginItem()
        if( obj.exist(name: self.appname) ) {
            let _ = obj.delete(name: self.appname)
            self.loginItemMenu.title = "Add login item"
        }else{
            let _ = obj.add(name: self.appname, path: Bundle.main.bundlePath)
            //self.loginItemMenu.title = "Delete login item"
            self.statusItem.menu?.removeItem(self.loginItemMenu)
        }
    }

}

