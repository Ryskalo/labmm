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
    
    func factorial(var value: Int) -> Float {
        
        var result:Float = 1
        for i in 1...value
        {
            result = result * Float(i);
        }
        
        return (result)
    }
    
    func summ(var p: Float, var x:Int) -> Float {
        
        var result:Float = 0
        for i in 1...x
        {
            result = result + (Float(p) / factorial(x))
        }
        
        return (result)
    }

    @IBAction func btnResult(sender: AnyObject) {
        var p = pFloat.floatValue
        var v = vFloat.floatValue
        
        
        //pvResult.floatValue = (Float((p) / (factorial(Int(v))))) / summ(p, x: Int(v))
        pvResult.floatValue = pow(3, 3)
        
    }
}
