// Student Name : VARUN DINESHBHAI PATEL
// Student ID : 101275495


//  WaitngViewController.swift
//  NewVirus
//
//  Created by apple on 4/12/20.
//  Copyright © 2020 apple. All rights reserved.
//



import UIKit

class WaitngViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var SortedArrayOfPatient = [Patients]();
    //var SortedArrayOfPatient = Global.sharedInstance.addedItemArray
    
    var myRefreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var PatientsTableView: UITableView!
    
    /*override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // For refresh data
        myRefreshControl.addTarget(self, action: #selector(WaitngViewController.handleRefresh), for: .valueChanged)
        PatientsTableView.refreshControl = myRefreshControl
        
        self.PatientsTableView.dataSource = self
        self.PatientsTableView.delegate = self
        
    }
    
    @objc func handleRefresh(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){
            (timer) in
            self.PatientsTableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }
    }
    
    
    // Total number of item you want to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return SortedArrayOfPatient.count
    }
    // Each row in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if(cell  == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "myCell")
        }
        
        cell?.textLabel?.text = "\(SortedArrayOfPatient[indexPath.row].patient_name)"
        cell?.detailTextLabel?.text = "Age : \(Int(SortedArrayOfPatient[indexPath.row].age))  Priority : \(SortedArrayOfPatient[indexPath.row].priorityOf)"
        
        if (SortedArrayOfPatient[indexPath.row].priorityOf == 3) {
            cell?.backgroundColor = UIColor.red
        } else if(SortedArrayOfPatient[indexPath.row].priorityOf == 2) {
            cell?.backgroundColor = UIColor.yellow
        }else if(SortedArrayOfPatient[indexPath.row].priorityOf == 1) {
            cell?.backgroundColor = UIColor.green
        }
        return cell!
    }
    
    // Detect touch or click
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hey You have Clicked on \(SortedArrayOfPatient[indexPath.row].patient_name))")
        let box = UIAlertController(
            title: "Patient’s Test",
            message: "Is the patient’s test complete ?",
            preferredStyle: .alert
        )
        box.addAction(
            UIAlertAction(title: "No", style: .default, handler: nil)
        )
        box.addAction(
            UIAlertAction(title: "Yes", style: .default, handler: {
                action in
                self.SortedArrayOfPatient.remove(at: indexPath.row)
                print("Removied From SortedArrayOf Patient")
              
                  print("Name OF Data Person which ---  \((self.tabBarController?.viewControllers?[0] as! ViewController).sortedPatient[indexPath.row].patient_name)")
                (self.tabBarController?.viewControllers?[0] as! ViewController).sortedPatient.remove(at: indexPath.row)
            })
        )
        
        // show alert box
        self.present(box, animated: true)
       
        myRefreshControl.addTarget(self, action: #selector(WaitngViewController.handleRefresh), for: .valueChanged)
        PatientsTableView.refreshControl = myRefreshControl
        
        self.PatientsTableView.dataSource = self
        self.PatientsTableView.delegate = self
    }
    

}
