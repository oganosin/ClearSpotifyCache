//
//  StringExtension.swift
//  ClearSpotifyCache
//
//  Created by Tsuyoshi Ogasawara on 2017/04/29.
//  Copyright © 2017年 Tsuyoshi Ogasawara. All rights reserved.
//

import Foundation

extension String {
    func isMatch(_ pattern:String)->Bool {
        do {
            let regex = try NSRegularExpression( pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches( in: self, options: [], range:NSMakeRange(0, self.characters.count) )
            if(matches.count > 0){
                return true
            }
        }catch let error as NSError {
            print(error.description)
        }
        return false
    }
}
