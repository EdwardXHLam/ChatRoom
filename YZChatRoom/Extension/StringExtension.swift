//
//  StringExtension.swift
//  U17
//
//  Created by charles on 2017/10/9.
//  Copyright © 2017年 None. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    
    public func subStringTo(endIndex: Int) -> String {
        return getString(startIndex: 0, endIndex: endIndex)
   }
    
    func getString(startIndex: Int, endIndex: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.startIndex, offsetBy: endIndex)
        return String (self[start ... end])
    }
    
    var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
    
    var md5: String {
        
        let ccharArray = self.cString(using: String.Encoding.utf8)
    
        var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5(ccharArray, CC_LONG(ccharArray!.count - 1), &uint8Array)
        
        return uint8Array.reduce("") { $0 + String(format: "%02X", $1)
        }
    }
}
