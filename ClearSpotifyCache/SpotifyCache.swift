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
        if(self.terminateSpotifyApp() == false){
            print("failed to terminate")
            // wait 3 sec more
            Thread.sleep(forTimeInterval: 3)
        }
        let _ = self.removeCashDir()
        if(self.launchSpotifyApp() == false){
            print("failed to lauch Spotify")
        }
    }
    
    func terminateSpotifyApp()->Bool{
        // get running App lists
        var Spotifies:[NSRunningApplication] = []
        let apps = NSWorkspace.shared().runningApplications
        for app in apps {
            if(app.localizedName == "Spotify" ||
                app.executableURL?.absoluteString == "file:///Applications/Spotify.app/Contents/MacOS/Spotify") {
                print(app.processIdentifier)
                print(app.executableURL!.absoluteString)
                Spotifies.append(app)
            }
        }
        
        if(Spotifies.count == 1){
            self.terminate()
        }else{
            for each in Spotifies {
                each.terminate()
            }
        }
        
        var waiting = 0
        while(self.isRunning()){
            Thread.sleep(forTimeInterval: 0.1)
            waiting += 1
            if(waiting > 10) {
                return false
            }
        }
        return true
    }

    private func terminate(waitUntilTerminated:Bool = true) {
        var appleScript:String = ""
        if(waitUntilTerminated) {
            appleScript = "if application \"Spotify\" is running\n"
                + "tell application \"Spotify\" to quit\n"
                + "repeat while application \"Spotify\" is running\n"
                + "delay 0.1\n"
                + "end repeat\n"
                + "end if\n"
        }else{
            appleScript = "if application \"Spotify\" is running\n"
                + "tell application \"Spotify\" to quit\n"
                + "end if\n"
        }
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&error)
            if error != nil {
                print(error.debugDescription)
            }
        }
    }
    
    func isRunning()->Bool{
        let apps = NSWorkspace.shared().runningApplications
        for app in apps {
            if(app.localizedName == "Spotify" ||
                app.executableURL?.absoluteString == "file:///Applications/Spotify.app/Contents/MacOS/Spotify") {
                if (app.isTerminated){
                    return false
                }
                return true
            }
        }
        return false
    }

    func launchSpotifyApp()->Bool{
        let appleScript = "tell application \"Spotify\"\n"
            + "activate\n"
            + "end tell\n"
            + "repeat\n"
            + "tell application \"System Events\" to exists application process \"Spotify\"\n"
            + "if result is true then exit repeat\n"
            + "delay 0.1\n"
            + "end repeat\n"
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&error)
            if error != nil {
                print(error.debugDescription)
                return false
            }
        }
        return true
    }
    
    func removeCashDir()->Bool{
        let fileManager = FileManager.default
        let root = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0]

        var target:[String] = []
        var isDir:ObjCBool = false
        if fileManager.fileExists(atPath: root, isDirectory:&isDir) {
            if isDir.boolValue {
                do {
                    let contents = try fileManager.contentsOfDirectory(atPath: root)
                    for file in contents {
                        if(file.isMatch("^Spotify")){
                            // it's spotify Dir
                            target.append(file)
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                    return false
                }
            }
        }else{
            return false
        }
        
        for each in target {
            let fullPath = root + "/" + each + "/" + "PersistentCache/"
            if fileManager.fileExists(atPath: fullPath){
                do {
                    try fileManager.removeItem(atPath: fullPath)
                } catch let error as NSError{
                    print(error.description)
                    return false
                }
            }
        }
        return true
    }
}
