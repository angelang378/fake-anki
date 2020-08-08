//
//  CharModel.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/1/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//

import Foundation

class CharModel {
    
    let notFive = [7, 9, 10]
    let cols = ["a", "i", "u", "e", "o"]
    let row7 = ["a", "u", "o"]
    let row9 = ["a", "o"]
    //row10 = "n"
    let rows = ["", "k", "s", "t", "n", "h", "m", "y", "r", "w", "n", "g", "z", "d", "b", "p"]
    
    var chosenChars = [Char]()
    var prefix = "h"
    var number = 0
    
    func getChars(sender:[Int]) -> [Char] {
        
        for num in sender {
            number = num
            if num > 16{
                prefix = "k"
                number -= 17
            } else{
                prefix = "h"
            }
            if !notFive.contains(number){
                for letter in cols {
                    let char = Char()
                    char.imageName = "\(prefix)char\(number)\(letter)"
                    char.value = "\(rows[number])\(letter)"
                    chosenChars.append(char)
                    
                }
            } else if number == 7{
                for letter in row7 {
                    let char = Char()
                    char.imageName = "\(prefix)char\(number)\(letter)"
                    char.value = "\(rows[number])\(letter)"
                    chosenChars.append(char)
                }
            } else if number == 9{
                for letter in row9 {
                    let char = Char()
                    char.imageName = "\(prefix)char\(number)\(letter)"
                    char.value = "\(rows[number])\(letter)"
                    chosenChars.append(char)
                }
            } else{
                let char = Char()
                char.imageName = "\(prefix)char\(number)n"
                char.value = "\(rows[number])"
                chosenChars.append(char)
            }
        }
        
        chosenChars.shuffle()
        return chosenChars
    }
    
}
