//
//  LoginItem.swift
//  ClearSpotifyCache
//
//  Created by Tsuyoshi Ogasawara on 2017/04/16.
//  Copyright © 2017年 Tsuyoshi Ogasawara. All rights reserved.
//

import Foundation
//import Cocoa

class LoginItem {

    func add(name:String,path:String)->Bool{
        let appleScript = "tell application \"System Events\"\n"
            + "make login item at end with properties {path:\"\(path)\", name:\"\(name)\"}\n"
            + "end tell\n"
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&error)
            if error != nil {
                print(error.debugDescription)
                return false
            }
        }else{
            return false
        }
        return true
        
    }

    func delete(name:String)->Bool{
        let appleScript = "tell application \"System Events\"\n"
            + "get the name of every login item\n"
            + "if login item \"\(name)\" exists then\n"
            + "delete login item \"\(name)\"\n"
            + "end if\n"
            + "end tell\n"
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&error)
            if error != nil {
                print(error.debugDescription)
                return false
            }
        }else{
            return false
        }
        return true
    }

    func exist(name:String)->Bool{
        let appleScript = "tell application \"System Events\"\n"
            + "get the name of every login item\n"
            + "if login item \"\(name)\" exists then\n"
            + "error \"registerd\"\n"
            //+ "return \"OK\""
            + "end if\n"
            + "end tell\n"
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            scriptObject.executeAndReturnError(&error)
            if error != nil {
                print(error.debugDescription)
                return true
            }
        }
        return false
    }

    
}
