//
//  Timer.swift
//  Timers-App
//
//  Created by Katrina Aliashkevich on 10/31/22.
//

import UIKit

// a global array that contains all the timers that every View Controller has access to
struct GlobalVariables {
    static var timerList:[Timer] = []
    // initiate the selectedTimer variable to be -1 (not in list, no index)
    static var selectedTimer = -1
}

class Timer {
    
    var event: String
    var location: String
    var remainingTime: Int
    
    init() {
        event = ""
        location = ""
        // remainingTime initiated to 0
        remainingTime = 0
    }

    // function that adds a Timer to the list
    static func addTimer() {
        // append the timer object to the global timerList
        GlobalVariables.timerList.append(Timer())
    }
}
