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
    let specialSound = [2, 3, 5, 12, 13] // technically 9 is here too, but hardcoded
    let changeSound = ["i", "u"]
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
                    char.value.append("\(rows[number])\(letter)")
                    if specialSound.contains(number) && changeSound.contains(letter){
                        switch (number, letter){
                        case (2, "i"):
                            char.value.append("shi")
                        case (3, "i"):
                            char.value.insert("chi", at: 0)
                        case (3, "u"):
                            char.value.insert("tsu", at: 0)
                        case (5, "u"):
                            char.value.insert("fu", at: 0)
                        case (12, "i"), (13, "i"):
                            char.value.insert("ji", at: 0)
                        default:
                            chosenChars.append(char)
                            continue
                        }
                    }
                    chosenChars.append(char)
                }
            } else if number == 7{
                for letter in row7 {
                    let char = Char()
                    char.imageName = "\(prefix)char7\(letter)"
                    char.value.append("\(rows[7])\(letter)")
                    chosenChars.append(char)
                }
            } else if number == 9{
                //decided to hardcode to be faster
                let char = Char()
                char.imageName = "\(prefix)char9a"
                char.value.append("wa")
                chosenChars.append(char)
                let char2 = Char()
                char2.imageName = "\(prefix)char9o"
                char2.value.append("o")
                char2.value.append("wo")
                chosenChars.append(char2)
                
            } else{
                let char = Char()
                char.imageName = "\(prefix)char10n"
                char.value.append("n")
                chosenChars.append(char)
            }
        }
        
        
        chosenChars.shuffle()
        return chosenChars
    }
    
}
