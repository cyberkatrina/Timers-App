//
//  AddTimerViewController.swift
//  Timers-App
//
//  Created by Katrina Aliashkevich on 10/31/22.
//

import UIKit

class AddTimerViewController: UIViewController {
    
    // create a variable for the textfield UI called eventText
    @IBOutlet weak var eventText: UITextField!
    // create a variable for the textfield UI called locationText
    @IBOutlet weak var locationText: UITextField!
    // create a variable for the textfield UI called totalTimeText
    @IBOutlet weak var totalTimeText: UITextField!
    
    // assign the delegate variable to the UpdateTable protocol
    var updateTableDelegate: UpdateTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // function executed when the save button is pressed
    @IBAction func savePressed(_ sender: Any) {
        // iterates through each timer in the global timerList
        for timer in GlobalVariables.timerList {
            // check if the event and location of the timer both equal to the evenText and locationText entered
            if (timer.event == eventText.text && timer.location == locationText.text) {
                // make the new remaining time of that timer be the totalTimeText in integer format
                timer.remainingTime = Int(totalTimeText.text!)!
                // run the UpdateTable function on the delegate
                updateTableDelegate?.updateTable()
                return
            }
        }
        // if the timer event and location aren't in an existing timer
        // create a new timer object from the Timer class, called timer
        let timer = Timer()
        // make the event of the timer be the eventText entered
        timer.event = ": " + eventText.text!
        // make the location of the timer be the locationText entered
        timer.location = ": " + locationText.text!
        // make the remainingTime of the timer be the totalTimeText entered
        timer.remainingTime = Int(totalTimeText.text!)!
        // append this timer to the global timerList
        GlobalVariables.timerList.append(timer)
        // run the UpdateTable function on the delegate
        updateTableDelegate?.updateTable()
    }
}
