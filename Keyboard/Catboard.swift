//
//  Catboard.swift
//  TransliteratingKeyboard
//
//  Created by Alexei Baboulevitch on 9/24/14.
//  Copyright (c) 2014 Alexei Baboulevitch ("Archagon"). All rights reserved.
//

import UIKit

/*
This is the demo keyboard. If you're implementing your own keyboard, simply follow the example here and then
set the name of your KeyboardViewController subclass in the Info.plist file.
*/

let kCatTypeEnabled = "kCatTypeEnabled"

class Catboard: KeyboardViewController {
    
    let takeDebugScreenshot: Bool = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        UserDefaults.standard.register(defaults: [kCatTypeEnabled: true])
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func translateKey(key: String) -> String {
        // This will map English keys to the one you specify.
        return "Meow"
        /***************************************************************
         
         Add you keys in here to translate. When the keyboard switch is on, it will map the corresponding key in case "keyname" to the newOutput"newValue"
         
         Example - to map "a"  to output "aye" you would have the following case
         
         case "a":
         newOutput = "aye"
         
         ****************************************************************/
        
        var newOutput = key
        
        
        switch key {
        case "a":
            newOutput = "a"
        case "b":
            newOutput = "b"
        case "c":
            newOutput = "c"
        case "d":
            newOutput = "d"
        case "e":
            newOutput = "e"
        case "f":
            newOutput = "f"
        case "g":
            newOutput = "g"
        case "h":
            newOutput = "h"
        case "i":
            newOutput = "i"
        case "j":
            newOutput = "j"
        case "k":
            newOutput = "k"
        case "l":
            newOutput = "l"
        case "m":
            newOutput = "m"
        case "n":
            newOutput = "n"
        case "o":
            newOutput = "o"
        case "p":
            newOutput = "p"
        case "q":
            newOutput = "q"
        case "r":
            newOutput = "r"
        case "s":
            newOutput = "s"
        case "t":
            newOutput = "t"
        case "u":
            newOutput = "u"
        case "v":
            newOutput = "v"
        case "w":
            newOutput = "w"
        case "x":
            newOutput = "x"
        case "y":
            newOutput = "y"
        case "z":
            newOutput = "z"
        case "A":
            newOutput = "A"
        case "B":
            newOutput = "B"
        case "C":
            newOutput = "C"
        case "D":
            newOutput = "D"
        case "E":
            newOutput = "E"
        case "F":
            newOutput = "F"
        case "G":
            newOutput = "G"
        case "H":
            newOutput = "H"
        case "I":
            newOutput = "I"
        case "J":
            newOutput = "J"
        case "K":
            newOutput = "K"
        case "L":
            newOutput = "L"
        case "M":
            newOutput = "M"
        case "N":
            newOutput = "N"
        case "O":
            newOutput = "O"
        case "P":
            newOutput = "P"
        case "Q":
            newOutput = "Q"
        case "R":
            newOutput = "R"
        case "S":
            newOutput = "S"
        case "T":
            newOutput = "T"
        case "U":
            newOutput = "U"
        case "V":
            newOutput = "V"
        case "W":
            newOutput = "W"
        case "X":
            newOutput = "X"
        case "Y":
            newOutput = "Y"
        case "Z":
            newOutput = "Z"
        default:
            return key
        }
        
        return newOutput
        
    }
    
    override func keyPressed(_ key: Key) {

        let textDocumentProxy = self.textDocumentProxy
        
        var keyOutput = (key: key.outputForCase(self.shiftState.uppercase()))
        
        if UserDefaults.standard.bool(forKey: kCatTypeEnabled) {
            keyOutput = translateKey(key: keyOutput)
        }
        
        textDocumentProxy.insertText(keyOutput)

    }
    
    override func createBanner() -> ExtraView? {
        return CatboardBanner(globalColors: type(of: self).globalColors, darkMode: false, solidColorMode: self.solidColorMode())
    }
    
    func takeScreenshotDelay() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Catboard.takeScreenshot), userInfo: nil, repeats: false)
    }
    
    func takeScreenshot() {
        if !self.view.bounds.isEmpty {
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            
            let oldViewColor = self.view.backgroundColor
            self.view.backgroundColor = UIColor(hue: (216/360.0), saturation: 0.05, brightness: 0.86, alpha: 1)
            
            let rect = self.view.bounds
            UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
            self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // HACK: Detecting orientation manually
            let screenSize: CGSize = UIScreen.main.bounds.size
            let orientation: UIInterfaceOrientation = screenSize.width < screenSize.height ? .portrait : .landscapeLeft
            let name = (orientation.isPortrait ? "Screenshot-Portrait" : "Screenshot-Landscape")
            let imagePath = "/Users/archagon/Documents/Programming/OSX/RussianPhoneticKeyboard/External/tasty-imitation-keyboard/\(name).png"
            
            if let pngRep = UIImagePNGRepresentation(capturedImage!) {
                try? pngRep.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
            }
            
            self.view.backgroundColor = oldViewColor
        }
    }
}

func randomCat() -> String {
    let cats = "🐱😺😸😹😽😻😿😾😼🙀"
    
    let numCats = cats.characters.count
    let randomCat = arc4random() % UInt32(numCats)
    
    let index = cats.characters.index(cats.startIndex, offsetBy: Int(randomCat))
    let character = cats[index]
    
    return String(character)
}
