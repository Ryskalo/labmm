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
    
    
    @IBAction func btnResult(sender: AnyObject) {               //Реализация после нажатия кнопки "Calculate"
        var p = pFloat.floatValue
        var v = vFloat.floatValue
        
        var pv = (pow(p, v) / (factorial(v))) / summ(p, v: v) //Рассчет Pv
        
        pvResult.floatValue = pv                              //Выводим результат в поле Pv
        
        if (checkValue(p, v: v)) {
            pvResult.floatValue = pv
        }
        else {
            pvResult.stringValue = "incorrect value"
        }
    }
    
    
    
    @IBAction func btnPT(sender: AnyObject) {                   //Реализация после нажатия кнопки "Plot & Table"
        arrayController.content?.removeAllObjects()             //Удаление из таблицы всех элементов
        
        var p = pFloat.floatValue
        var v = vFloat.floatValue
        
        if (checkValue(p, v: v))
        {
            var pkStr:String = ""
            var a:Float = 0
            var dic:[String:String]
            
            for i in 0 ... Int(v) {
                a = Float((pow(p, Float(i+1))/factorial(Float(i+1))) / (summ(p, v: Float(v))))      //Рассчет массива Pk
                
                if (i == Int(v)){                                   //Создание строки с элементами массива Pk
                    pkStr += "\(a)"
                }
                else {
                    pkStr += "\(a), "
                }
                dic = ["x":"\(i)","pk":"\(a)"]
                arrayController.addObject(dic)                      //Вывод элементов массива Pk в таблицу
            }
            
            var points:String = ""
            var i = 1
            
            for i in 0...Int(v){                                    //Создание строки с нумерацией для графика
                if (i == Int(v)) {
                    points += "\"" + String(i) + "\""
                }
                else {
                    points += "\"" + String(i) + "\", "
                }
            }
            
            buildChart(pkStr, points: points)                       //Вызов функции построения графика
        }
        else
        {
            pvResult.stringValue = "incorrect value"
        }
        
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {     //Действие после запуска программы
        
        let pkStr = "1, 1, 1, 1, 1"                             //Задаем значения графика при запуске программы
        
        let points = "\"1\", \"2\", \"3\", \"4\", \"5\""
        
        buildChart(pkStr, points: points)                       //Вызов функции построения графика
        
    }

    
    
    func applicationWillTerminate(aNotification: NSNotification) {

    }
    
    
    
    func factorial(var value: Float) -> Float {             //Функция для рассчета факториала
        
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
    
    
    
    func summ(var p: Float, v: Float) -> Float {           //Функция рассчета суммы
        var result:Float = 0
        for i in 0 ... Int(v) {
            result = result + pow(p,Float(i)) / factorial(Float(i))
        }
        
        return result
    }
    
    
    
    func checkValue(var p:Float, v:Float ) -> Bool {            //функция проверки значений
        if ((p == 0) || (v == 0) || (p > v)) {
            return false
        }
        else {
            return true
        }
    }
    
    
    
    func buildChart(var pkStr: String , points: String) {    //Функция построения графика
        var resourcesPath = NSBundle.mainBundle().pathForResource("index", ofType: "html") //Указываем путь к html файлу с вызовом библиотеки для графиков
        
        var url = NSURL(fileURLWithPath:resourcesPath!)                                     //Создаем ссылку на html файл
        
        let htmlContent = NSMutableString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error:nil)   //Считываем html файл в строковую переменную
        
        htmlContent?.insertString(pkStr, atIndex: 701)                                  //Вставляем строку с массивом Pk в считанный html код
        htmlContent?.insertString(points, atIndex: 379)                                 //Вставляем строку с нумерацией графика
        
        self.wChart.mainFrame.loadHTMLString(htmlContent, baseURL: url)                 //Выводим полученный html код в элемент WebView
    }
    
}
