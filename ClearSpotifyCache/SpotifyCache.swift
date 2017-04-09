//
//  SpotifyCache.swift
//  ClearSpotifyCache
//
//  Created by Tsuyoshi Ogasawara on 4/9/17.
//  Copyright © 2017 Tsuyoshi Ogasawara. All rights reserved.
//

import Foundation
import Cocoa

class SpotifyCache {
    
    func deleteAllCash(){
        self.terminateSpotifyApp()
        self.removeCashDir()
        self.activateSpotifyApp()
    }
    
    func terminateSpotifyApp(){
        let appleScript = "if application \"Spotify\" is running\n"
            + "tell application \"Spotify\" to quit\n"
            + "repeat while application \"Spotify\" is running\n"
            + "delay 0.1\n"
            + "end repeat\n"
            + "end if\n"
        //let _ = NSAppleScript(source: appleScript)
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&error)
            if error != nil {
                print(error.debugDescription)
            }
        }
    }
    
    func activateSpotifyApp(){
        let appleScript = "tell application \"Spotify\"\n"
            + "activate\n"
            + "end tell"
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&error)
            if error != nil {
                print(error.debugDescription)
            }
        }
    }
    
    func removeCashDir(){
        let fileManager = FileManager.default
        let target = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] + "/Spotify/PersistentCache/"
        if fileManager.fileExists(atPath: target){
            do {
                try fileManager.removeItem(atPath: target)
            } catch let error as NSError{
                print(error.description)
            }
        }
    }
}
