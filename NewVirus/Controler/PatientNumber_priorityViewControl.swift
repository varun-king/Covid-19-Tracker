//
// Student Name : VARUN DINESHBHAI PATEL
// Student ID : 101275495

//  PatientNumber_priorityViewControl.swift
//  NewVirus
//
//  Created by apple on 4/12/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class PatientNumber_priorityViewControl: UIViewController {

    var patient_name = ""
    var patient_age = 0.0
    var patient_priority = 0
    var patient_waitng_number = 0
    
    @IBOutlet weak var textviewForPatintInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textviewForPatintInfo.text = "Patient Name : \(patient_name) \n Patient Age: \(Int(patient_age)) \n Patient Priority : \(patient_priority) \n Patient Waiting Number : \(patient_waitng_number)"
        
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
