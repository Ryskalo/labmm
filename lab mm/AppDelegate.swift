//
//  AppDelegate.swift
//  lab mm
//
//  Created by Антон Рыскалев on 17.10.14.
//  Copyright (c) 2014 Антон Рыскалев. All rights reserved.
//

import Cocoa
import WebKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var pFloat: NSTextField!
    @IBOutlet weak var vFloat: NSTextField!
    @IBOutlet weak var pvResult: NSTextField!
    @IBOutlet weak var wChart: WebView!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var arrayController: NSArrayController!
    
    
    @IBAction func btnResult(sender: AnyObject) {
        var p = pFloat.floatValue
        var v = vFloat.floatValue
        
        var pv = (pow(p, v) / (factorial(v))) / summ(p, v: v)
        
        pvResult.floatValue = pv
        
        if ((pv == 0) || (p == 0) || (v == 0))
        {
            pvResult.stringValue = "incorrect value"
        }
        
    }
    
    
    
    @IBAction func btnPT(sender: AnyObject) {
        arrayController.content?.removeAllObjects()
        
        var p = pFloat.floatValue
        var v = vFloat.floatValue
        
        var pk = [Float]()
        var pkStr:String = ""
        var a:Float = 0
        
        var dic:[String:String]
        
        for i in 0 ... Int(v) {
            a = Float((pow(p, Float(i))/factorial(Float(i))) / (summ(p, v: Float(i))))
            pk.insert(a, atIndex: i)
            
            if (i == Int(v)){
                pkStr += "\(a)"
            }
            else {
                pkStr += "\(a), "
            }
            dic = ["x":"\(i)","pk":"\(a)"]
            arrayController.addObject(dic)
        }
        
        var points:String = ""
        var i = 1
        
        for i in 0...Int(v){
            if (i == Int(v)) {
                points += "\"" + String(i) + "\""
            }
            else {
                points += "\"" + String(i) + "\", "
            }
        }
        
        buildChart(pkStr, points: points)
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        let pkStr = "1, 1, 1, 1, 1"
        
        let points = "\"1\", \"2\", \"3\", \"4\", \"5\""
        
        buildChart(pkStr, points: points)
        
    }

    
    
    func applicationWillTerminate(aNotification: NSNotification) {

    }
    
    
    
    func factorial(var value: Float) -> Float {
        
        if (value < 0)
        {
            return 0
        }
        else if (value == 0)
        {
            
            return 1
        }
        else
        {
            return (value * factorial(value - 1))
        }
    }
    
    
    
    func summ(var p: Float, v: Float) -> Float {
        var result:Float = 0
        for i in 0 ... Int(v) {
            result = result + pow(p,Float(i)) / factorial(Float(i))
        }
        
        return result
    }
    
    func buildChart(var pkStr: String , points: String) {
        var resourcesPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        
        var url = NSURL(fileURLWithPath:resourcesPath!)
        
        let htmlContent = NSMutableString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error:nil)
        
        htmlContent?.insertString(pkStr, atIndex: 701)
        htmlContent?.insertString(points, atIndex: 379)
        
        self.wChart.mainFrame.loadHTMLString(htmlContent, baseURL: url)
    }
    
}
