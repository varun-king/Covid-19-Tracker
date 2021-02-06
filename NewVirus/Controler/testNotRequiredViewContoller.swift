//
// Student Name : VARUN DINESHBHAI PATEL
// Student ID : 101275495

//  testNotRequiredViewContoller.swift
//  NewVirus
//
//  Created by apple on 4/13/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class testNotRequiredViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var SortedArrayOfNoTestPatient = [Patients]();
    
    //var SortedArrayOfPatient = Global.sharedInstance.addedItemArray
    
    var myRefreshControl = UIRefreshControl()

    @IBOutlet weak var PatientsTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         SortedArrayOfNoTestPatient = SortedArrayOfNoTestPatient.sorted(by: { $0.patient_name < $1.patient_name })
        // For refresh data
        myRefreshControl.addTarget(self, action: #selector(testNotRequiredViewContoller.handleRefresh), for: .valueChanged)
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return SortedArrayOfNoTestPatient.count
    }
    // Each row in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        if(cell  == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "myCell")
        }
        var travelHistory:String = ""
        
        if(SortedArrayOfNoTestPatient[indexPath.row].travel == true){
                travelHistory = "Yes"
        }else{
            travelHistory = "No"
        }
        
        cell?.textLabel?.text = "\(SortedArrayOfNoTestPatient[indexPath.row].patient_name)"
        cell?.detailTextLabel?.text = "Age : \(Int(SortedArrayOfNoTestPatient[indexPath.row].age))  Travel History : \(travelHistory)"
        
        
        return cell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
