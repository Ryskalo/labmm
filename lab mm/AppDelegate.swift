//
//  AppDelegate.swift
//  lab mm
//
//  Created by Антон Рыскалев on 17.10.14.
//  Copyright (c) 2014 Антон Рыскалев. All rights reserved.
//

import Cocoa
import WebKit
//import WKWebView

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var pFloat: NSTextField!
    @IBOutlet weak var vFloat: NSTextField!
    @IBOutlet weak var pvResult: NSTextField!
    @IBOutlet weak var wChart: WebView!
    
    
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
        
        var pv = (p / (factorial(v))) / summ(p, v: v)
        
        pvResult.floatValue = pv
        
        if (pv == 0)
        {
            pvResult.stringValue = "Введите корректные значения"
        }
        
        var resourcesPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        
        //var htmlPath = resourcesPath!.stringByAppendingString("/index.html")
        
        var url = NSURL(fileURLWithPath:resourcesPath!)
        
        //var request = NSURLRequest(URL: url!)
        
        
        let htmlContent = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error:nil)
        
        //println(htmlContent)
        
        self.wChart.mainFrame.loadHTMLString(htmlContent, baseURL: url)
        
        //self.wChart.frameLoadDelegate = self
        //self.wChart.mainFrame.loadRequest(request)
        
        
        /*
NSString* filePath = [[NSBundle mainBundle] pathForResource: @"index" ofType: @"html"];
NSURL *url = [NSURL fileURLWithPath:[filePath stringByDeletingLastPathComponent]];
[[self.webView mainFrame] loadHTMLString: [NSString stringWithContentsOfFile: filePath] baseURL: url];
*/

    }
    
    func userContentController(userContentController: WKUserContentController!,didReceiveScriptMessage message: WKScriptMessage!) {
        if(message.name == "callbackHandler") {
            println("JavaScript is sending a message \(message.body)")
        }
    }
}
