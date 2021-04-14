//
//  StringHelper.swift
//  LeleGroup
//
//  Created by Delvina Janice on 14/04/21.
//

import Foundation

class StringHelper: NSObject {
    func getFirstWord(start: Int,words: String) -> String{
        
        let text = words
        let index = text.index(text.startIndex, offsetBy: start)

        let mySubstring = text[..<index]
        
        return String(mySubstring)
    }
    
    func getMiddleWord(start: Int, end: Int, words: String) -> String{
        let text = words
        let start = text.index(text.startIndex, offsetBy: start)
        let end = text.index(text.endIndex, offsetBy: end)
        let range = start..<end
        let mySubstring = text[range]
        
        return String(mySubstring)
    }
}
