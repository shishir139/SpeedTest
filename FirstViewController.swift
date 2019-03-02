//
//  FirstViewController.swift
//  SpeedTest
//
//  Created by Jindal, Shishir on 7/18/17.
//  Copyright © 2017 Jindal, Shishir. All rights reserved.
//

import UIKit
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var alreadyAdded = Set<Iterator.Element>()
        return self.filter { alreadyAdded.insert($0).inserted }
    }
}

var currentUser: String = ""
var arrayOfUserNames = [String]()
var arrayOfWordsPerMinuteSpeed = [Double]()
var defaultWordsPerMinute: Double = 120
var distinctUserNames = arrayOfUserNames.unique()
var speed: Float = 1
var delay: Int = 2
var defaultTimeInterval: Double = 0.5
var timeInterval:Double = 1.0
var user: String = ""


var tempText: String = ""
 var tries = [Int]()

//var userEntryTuple : (String,Double) = ("", 0)
//var userEntryArray = [userEntryTuple]
class FirstViewController: UIViewController {
    var filemgr:FileManager!
    var result = [String]()
    var timer = Timer()
    var wordsPerMinute: Double = 0
    
    var fetchedArray = [String]()
   
    var countNoOfTimesFileRead: Int = 0
    var p: Int = 0
    
    var tempUser = ""
    var tempWpm: Double = 0.0
    
    var color :Int = 0
    var firstTime = true
    var counter = 0.0
    var timerScheduled = false
        var i : Int = 0
    @IBOutlet weak var wpm: UITextField!
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var displayResult: UILabel!
   
    @IBOutlet weak var showUsername: UILabel!
    @IBOutlet weak var messageDisplay: UILabel!
    
    func updateCounter() {
        if p < result.endIndex {
       // displayResult.text = result[p]
         var length = result[p].characters.count
           // print(length)
            if length % 2 == 0 {
                color = length/2
            } else if length == 1 {
                color = length
            }
            
            else if length % 2 != 0{
                color = ((length-1) / 2) + 1
            }
            let myMutableString = NSMutableAttributedString(string: result[p])
            myMutableString.addAttribute(NSForegroundColorAttributeName, value : UIColor.blue, range: NSRange(location: color - 1, length: 1))
            displayResult.attributedText = myMutableString

            if p == result.endIndex - 1 {
                countNoOfTimesFileRead = countNoOfTimesFileRead + 1
                p = -1
            }
        p = p + 1
        }
        else {
            displayResult.text = "File complete reading"
        }
    }
    
    
    func arrayOfUsernamesAndarrayOfWpm() {
        var determineResult = [String]()
        
        determineResult = tempText.components(separatedBy: "\n")
        var dummyArray = [String]()
        for i in 0..<determineResult.endIndex {
            dummyArray = determineResult[i].components(separatedBy: " ")
            print(dummyArray)
            arrayOfUserNames.insert(dummyArray[0], at: i)
            arrayOfWordsPerMinuteSpeed.insert(Double(dummyArray[1])!, at: i)
            
        }
        calculateNoOfTries()
        print(tries)
        print(distinctUserNames)
    }
    
    func calculateNoOfTries() {
        var i : Int = 0
        var j: Int = 0
        var count:Int = 0
        var temp : Int = 0
        //distinctUserNames
        var checkSameUser : String = ""
        for i in 0..<distinctUserNames.endIndex {
            checkSameUser = distinctUserNames[i]
            for j in 0..<arrayOfUserNames.endIndex {
                if checkSameUser == arrayOfUserNames[j] {
                    count = count + 1
                } }
            
                temp = i
            print(temp)
               tries.insert(count, at: i)
                count = 0
            
            
            print(checkSameUser)
            }
                    }
    
    
    @IBAction func Play(_ sender: UIButton) {
    
        //print("second play")
        if wpm.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
        wordsPerMinute = Double(wpm.text!)!
            timeInterval = 60 / wordsPerMinute
            
            if tempWpm != wordsPerMinute {
                p = 0
                countNoOfTimesFileRead = 0
            }
        }
         else {
            wordsPerMinute = defaultWordsPerMinute
            timeInterval = defaultTimeInterval
        }
        
        tempWpm = wordsPerMinute
        
        //        let file = "file.txt" //this is the file. we will write to and read from it
        //
        //        let text = username.text!
        //
        //        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //
        //        if let path = dir?.appendingPathComponent(file) {
        //            //print(path)
        //            //writing
        //            do {
        //                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        //            }
        //            catch {
        //                print ("Error writing to the file")
        //            }
        //
       
        
        if username.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
        user = username.text!
        currentUser = user
            
            if tempUser != currentUser {
                p = 0
                countNoOfTimesFileRead = 0
            }
        }
        tempUser = currentUser
        //userEntryTuple = (user, Double(wordsPerMinute))
        //print(userEntryTuple.0)
        
        
        
        if currentUser != "" {
        var finalValue : String = "\(currentUser) \(wordsPerMinute)"
        
        let path = "/Users/jindals2690/Documents/username.txt"
        
        do {
            if filemgr.fileExists(atPath: path) {
                if var text = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
                    
                    var checkResult: String = ""
                    fetchedArray = text.components(separatedBy: "\n")
                    
                    
                    checkResult = String(describing: fetchedArray)
                    
                    
                    if checkResult.contains(user) {
                        
                        
                        messageDisplay.text = "Username already exists"
                        showUsername.text = "\(currentUser) logged in"
                        if ((p == 0) && (countNoOfTimesFileRead == 0)) {
                        do {
                            text = text + "\n" + "\(currentUser) \(wordsPerMinute)"
                            tempText = text
                            try text.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
                            arrayOfUsernamesAndarrayOfWpm()
                        }
                        catch {
                            print("Error occured")
                        }
                        }
                    }
                        
                        
                    else {
                        if ((p == 0) && (countNoOfTimesFileRead == 0)) {
                        do {
                            text = text + "\n" + finalValue
                            tempText = text
                            try text.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
                            showUsername.text = "\(currentUser) logged in "
                            arrayOfUsernamesAndarrayOfWpm()
                            
                        } catch _ {
                            print("Error writing to the file")
                        }
                        }
                    }
                    
                    
                    
                    
                    let path2 = Bundle.main.path(forResource: "myFile", ofType: "txt")
                    let data = try? String(contentsOfFile: path2!, encoding: String.Encoding.utf8)
                    result = (data?.components(separatedBy: " "))!
                    //                for i in 0..<result.endIndex {
                    //                print(result[i])
                    //                }
                    
                    //speed = Int(wpm.text!)!
                    
                    if (!timerScheduled) {
                        timerScheduled = true
                        if(firstTime) {
                            sleep(UInt32(delay))
                            firstTime = false
                        }
                        
                        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(FirstViewController.updateCounter), userInfo: nil, repeats: true)
                        
                        
                        RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
                        timer.fire()
                        
                        
                    }
                }
            }
        }
        
        
        catch {
            print("Error reading form the file ")
        }
        
        } else {
            let alert = UIAlertController(title: "No user logged in. kindly enter username or switch user through Settings. Thanks", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title : "Ok", style: .default ,handler : { _ in }))
            self.present(alert, animated: false, completion: {})
        }
    }
    
        
    
        
        
    
    @IBAction func pause(_ sender: UIButton) {
        timerScheduled = false
        timer.invalidate()
        
       //displayResult.text = "      "
        
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        filemgr = FileManager.default
   //  displayResult.text = "      "
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

