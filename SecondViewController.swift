//
//  SecondViewController.swift
//  SpeedTest
//
//  Created by Jindal, Shishir on 7/18/17.
//  Copyright © 2017 Jindal, Shishir. All rights reserved.
//

import UIKit
var maxWpmOfUser = [Double]()
var sortedUserName = [String]()
var countUser :Int = 0
class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var display: UITextView!
    @IBOutlet weak var mostRecentTry: UILabel!
    @IBOutlet weak var secondLastTry: UILabel!
    
    @IBOutlet weak var showUserTries: UILabel!
    @IBOutlet weak var thirdLastTry: UILabel!
    
    @IBOutlet weak var showCurrentUserName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func calUseTries() {
        var i: Int = 0
        for i in 0..<arrayOfUserNames.endIndex {
            if currentUser == arrayOfUserNames[i] {
                countUser = countUser + 1
            }
        }
    }
    
    func calWpmMax() {
      //  var i: Int = 0
       // var j: Int = 0
        var max: Double = 0.0
        for j in 0..<distinctUserNames.endIndex{
        for i in 0..<arrayOfUserNames.endIndex {
            if distinctUserNames[j] == arrayOfUserNames[i] {
                if (arrayOfWordsPerMinuteSpeed[i] > max) {
                    print(max)
                max = arrayOfWordsPerMinuteSpeed[i]
                    print(max)
                }
                
            }
           
            }
            print(max)
            maxWpmOfUser.insert(max, at: j)
            max = 0
            
        }
        
        //print(maxWpmOfUser)
    }
    
    func sortWpm() {
        sortedUserName = distinctUserNames
        var max = maxWpmOfUser[0]
        var temp : String = ""
        for j in 0..<maxWpmOfUser.endIndex{
            for i in 0..<maxWpmOfUser.endIndex {
                if i != maxWpmOfUser.endIndex {
                    if maxWpmOfUser[i] < maxWpmOfUser[j] {
                        temp = sortedUserName[i]
                        max = maxWpmOfUser[i]
                        sortedUserName[i] = sortedUserName[j]
                        maxWpmOfUser[i] = maxWpmOfUser[j]
                        sortedUserName[j] = temp
                        maxWpmOfUser[j] = max
                        
                    }}
            }}
        //        for i in 0..<maxWpmOfUser.endIndex {
        //
        //        }
        print(maxWpmOfUser)
    }
    
    @IBAction func show(_ sender: UIButton) {
        var result: String = ""
        
        print("show entered")
//        for i in 0..<tries.endIndex {
//            
//            result = result + "\(distinctUserNames[i]) \(tries[i]) \n"
//        }
        var i: Int = arrayOfUserNames.endIndex - 1
        var count : Int = 0
        var arrayOfTries = [Double]()
    
        while ((i >= 0) && (count < 3)) {
            
            if currentUser == arrayOfUserNames[i] {
                
                arrayOfTries.insert(Double(arrayOfWordsPerMinuteSpeed[i]), at: count)
                
                count = count + 1
            }
            i = i - 1
        }
        
        print("printing array of tries ")
    
        print(arrayOfTries)
        
        if count == 1 {
            mostRecentTry.text = String(arrayOfTries[0])
            secondLastTry.text = ""
            thirdLastTry.text = ""
        }
        else if count == 2 {
            mostRecentTry.text = String(arrayOfTries[0])
            secondLastTry.text = String(arrayOfTries[1])
            thirdLastTry.text = ""
        }
        
        else if count == 3 {
            mostRecentTry.text = String(arrayOfTries[0])
            secondLastTry.text = String(arrayOfTries[1])
            thirdLastTry.text = String(arrayOfTries[2])
        }
        showCurrentUserName.text = currentUser
        
        calUseTries()
        showUserTries.text = String(countUser)
       // display.text = result
        
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return maxWpmOfUser.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if maxWpmOfUser.isEmpty {
            return "No users logged in "
            
        }
        else {
            return "List of Users and their tries"
        }
    }
    
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transactionIdentfier = "cellDisplay"
        let cell = tableView.dequeueReusableCell(withIdentifier: transactionIdentfier, for: indexPath)
       // var transaction = Transaction()
        
       // cell.detailTextLabel?.text = "\(transaction.date)"
        //transaction = model.transactionAtIndex(indexPath.row)
//        cell.textLabel!.text = "\(arrayOfUserNames[indexPath.row])  \(arrayOfWordsPerMinuteSpeed[indexPath.row]) "
        
        cell.textLabel!.text = "\(sortedUserName[indexPath.row])  \(maxWpmOfUser[indexPath.row])"
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        calWpmMax()
        sortWpm()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

