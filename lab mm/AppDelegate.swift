//
//  AppDelegate.swift
//  lab mm
//
//  Created by Антон Рыскалев on 17.10.14.
//  Copyright (c) 2014 Антон Рыскалев. All rights reserved.
//

import Cocoa
import WebKit
//import AppKit
//import Foundation
//import WKWebView

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var pFloat: NSTextField!
    @IBOutlet weak var vFloat: NSTextField!
    @IBOutlet weak var pvResult: NSTextField!
    @IBOutlet weak var wChart: WebView!
    @IBOutlet weak var myTableView: NSTableView!
    @IBOutlet weak var arrayController: NSArrayController!
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        var resourcesPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        
        var url = NSURL(fileURLWithPath:resourcesPath!)
        
        let htmlContent = NSMutableString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error:nil)
        
        let pkStr = "1, 1, 1, 1, 1"
        
        let points = "\"1\", \"2\", \"3\", \"4\", \"5\""
        
        htmlContent?.insertString(pkStr, atIndex: 701)
        htmlContent?.insertString(points, atIndex: 379)
        
        self.wChart.mainFrame.loadHTMLString(htmlContent, baseURL: url)
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {

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
        
        var pv = (pow(p, v) / (factorial(v))) / summ(p, v: v)
        
        pvResult.floatValue = pv
        
        if ((pv == 0) || (p == 0) || (v == 0))
        {
            pvResult.stringValue = "incorrect value"
        }
        
        //var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
       // var dic:[String:String] = ["demoKey":"name","name1":"name1"]
        //dic["name"] = "tony"
        //arrayController.addObject(dic)
        
        var pk = [Float]()
        var pkStr:String = ""
        var a:Float = 0
        
        for i in 0 ... Int(v) {
            a = (pow(p, Float(i))/factorial(Float(i))) / (summ(p, v: Float(i)))
            pk.insert(a, atIndex: i)
            //println(pk[i])
            
            if (i == Int(v)){
                pkStr += "\(a)"
            }
            else {
                pkStr += "\(a), "
            }
        }
        
        var points:String = ""
        var i = 1
        
        for i in 1...Int(v){
            if (i == Int(v)) {
               points += "\"" + String(i) + "\""
            }
            else {
                points += "\"" + String(i) + "\", "
            }
        }
        
        //var indexPk = 699 + 5 * Int(v)
        
        //println(pk)
        
        var resourcesPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        
        var url = NSURL(fileURLWithPath:resourcesPath!)
        
        let htmlContent = NSMutableString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error:nil)
        
        htmlContent?.insertString(pkStr, atIndex: 701)
        htmlContent?.insertString(points, atIndex: 379)
        
        self.wChart.mainFrame.loadHTMLString(htmlContent, baseURL: url)
    

    }
    
}
