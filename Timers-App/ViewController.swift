//
//  ViewController.swift
//  Timers-App
//
//  Created by Katrina Aliashkevich on 10/31/22.
//

import UIKit

// initualize UpdateTable protocol that runs the updateTable() function
protocol UpdateTable {
    func updateTable()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTable {
    
    // create a variable for the tableView UI called tableView
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TimerTable-ViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // count the number of timer objects in the global timer list
        return GlobalVariables.timerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // assign cell to be the selected cell in tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        // assign row to be the selected row index of the tableView
        let row = indexPath.row
        // assign timer to be the timer in global timer List at the same index as row
        let timer = GlobalVariables.timerList[row]
        // update the textLabel of the current cell to be the event, location, and remaining time of the timer in timer list with the same index
        cell.textLabel?.text = "Event \(timer.event)\n                                                               Remaining Time(s) \(timer.remainingTime)\nLocation \(timer.location)"
        return cell
    }
    
    // function runs before both segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // when we navigate to add a timer
        if segue.identifier == "AddTimerSegue",
            let nextVC = segue.destination as? AddTimerViewController {
             // make current View Controller the delegate of nextVC
             nextVC.updateTableDelegate = self
         }
        // when we navigate to countdown from an existing timer
        else if segue.identifier == "CountdownSegue" {
            // make the global selected timer be the index of the selected tableView cell (row) in integer form
            GlobalVariables.selectedTimer = Int(tableView.indexPathForSelectedRow!.row)
        }
            // change the 'back' navigation arrow to say 'Timer' instead
            let backItem = UIBarButtonItem()
            backItem.title = "Timer"
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    
    // function that updates the data in the table
    func updateTable() {
        tableView.reloadData()
    }
    
    // update the table again every time this view controller appears
    override func viewWillAppear(_ animated: Bool) {
        updateTable()
    }
}
