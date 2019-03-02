//
//  Settings.swift
//  SpeedTest
//
//  Created by Jindal, Shishir on 7/18/17.
//  Copyright © 2017 Jindal, Shishir. All rights reserved.
//

import UIKit


class Settings: UIViewController {

    @IBOutlet weak var defaultSpeed: UITextField!
    @IBOutlet weak var defaultDelay: UITextField!
    @IBOutlet weak var switchUserDetails: UITextField!
    @IBAction func settings(_ sender: UIButton) {
        if defaultSpeed.text != "" {
    defaultWordsPerMinute = Double(defaultSpeed.text!)!
            defaultTimeInterval = 60 / defaultWordsPerMinute
        }
        
        if defaultDelay.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
            delay = Int(defaultDelay.text!)! }
        
        if switchUserDetails.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
        currentUser = switchUserDetails.text!
        }
        
        if (defaultSpeed.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "" ) && (defaultDelay.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "") && (switchUserDetails.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "") {
            let alert = UIAlertController(title: "No settings changed. Kindly set atleast one of the above values to proceed. Thanks", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title : "Ok", style: .default ,handler : { _ in }))
            self.present(alert, animated: false, completion: {})
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
