//
//  AppDelegate.swift
//  lab mm
//
//  Created by Антон Рыскалев on 17.10.14.
//  Copyright (c) 2014 Антон Рыскалев. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var pFloat: NSTextField!
    @IBOutlet weak var vFloat: NSTextField!
    @IBOutlet weak var pvResult: NSTextField!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func factorial(var value: Float) -> Float {
        
        if (value < 0) // если пользователь ввел отрицательное число
        {
            return 0 // возвращаем ноль
        }
        else if (value == 0) // если пользователь ввел ноль,
        {
            
            return 1 // возвращаем факториал от нуля - не удивляетесь, но это 1 =)
        }
        else // Во всех остальных случаях
        {
            return (value * factorial(value - 1)) // делаем рекурсию.
        }
    }
    
    func summ(var p: Float, v: Float) -> Float {
        var result:Float = 0
        for i in 0 ... Int(v) {
            result = result + pow(p,Float(i)) / factorial(Float(i))
        }
        
        return result
    }

    @IBAction func btnResult(sender: AnyObject) {
        var p = pFloat.floatValue
        var v = vFloat.floatValue
        
        
        pvResult.floatValue = (p / (factorial(v))) / summ(p, v: v)
        //pvResult.floatValue = pow(3, 3)
        
    }
}
