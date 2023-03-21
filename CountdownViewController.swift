//
//  CountdownViewController.swift
//  Timers-App
//
//  Created by Katrina Aliashkevich on 10/31/22.
//

import UIKit
import Foundation

class CountdownViewController: UIViewController {

    // create a variable for the label UI called eventLabel
    @IBOutlet weak var eventLabel: UILabel!
    // create a variable for the label UI called locationLabel
    @IBOutlet weak var locationLabel: UILabel!
    // create a variable for the label UI called remainingTimeLabel
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    // initiate the variable thread of the type Thread
    static var thread: Thread?
    // initiate the variable activeTimer of the type CountdownViewController
    static var activeTimer: CountdownViewController?
    
    // the multi-threading function that takes an activeTimer as a parameter
    static func initThread(activeTimer: CountdownViewController) {
        CountdownViewController.activeTimer = activeTimer
        // if the thread already exists, don't create a new thread and just exit
        if thread != nil {
            return
        }
        // assign the thread variable to the inline Thread class
        thread = Thread {
            // infinite while loop
            while true {
                // pause for 1 second
                sleep(1)
                // if the selected timer is less than 1 (no index)
                if GlobalVariables.selectedTimer < 0 {
                    // jump back to the beginning of the while loop
                    continue
                }
                // make timer the timer object from global timerList at index selectedTimer
                let timer = GlobalVariables.timerList[GlobalVariables.selectedTimer]
                // if the time remaining on the timer is greater than 0
                if timer.remainingTime > 0 {
                    // decrement the remaining time of the timer by 1
                    timer.remainingTime -= 1
                    // run the following asyncronously in the main dispatch queue to priorotize it
                    DispatchQueue.main.async {
                        // adjust the remaining time label of the active timer in string format
                        CountdownViewController.activeTimer!.remainingTimeLabel.text = String(timer.remainingTime)
                    }
                }
            }
        }
        // create a new thread
        thread!.start()
    }
    
    // function runs before we leave the current view controller
    override func viewWillDisappear(_ animated: Bool) {
        // assign the global selectedTimer to -1 (no index)
        GlobalVariables.selectedTimer = -1
    }
    
    // function runs before we enter the current view
    override func viewWillAppear(_ animated: Bool) {
        // run the initThread function with self as the active timer parameter
        CountdownViewController.initThread(activeTimer: self)
    }
    
    // function runs when the current view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        // if the selected timer is less than 1 (no index)
        if GlobalVariables.selectedTimer < 0 {
            return
        }
        // make timer the timer object from global timerList at index selectedTimer
        let timer = GlobalVariables.timerList[GlobalVariables.selectedTimer]
        // make the text in the eventLabel match the event of the selected timer
        eventLabel.text = timer.event
        // make the text in the locationLabel match the location of the selected timer
        locationLabel.text = timer.location
        // make the text in the remainingTimeLabel match the remaining time of the selected timer in string format
        remainingTimeLabel.text = String(timer.remainingTime)
    }
}
