//
// Student Name : VARUN DINESHBHAI PATEL
// Student ID : 101275495

//  ViewController.swift
//  NewVirus
//
//  Created by apple on 4/12/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ArrayOfPatient = [Patients]();
    var sortedPatient = [Patients]();
    var TestNotRequire = [Patients]();
    
    var age:Double = 0.0
    var dob:String = ""
    var nameOfPatient:String = ""
    var priority:Int = 0
    var waiting_number = 0
    
    
    @IBOutlet weak var patient_name: UITextField!
    @IBOutlet weak var inputDatePicker: UITextField!
    @IBOutlet weak var travelled: UISwitch!
    private var datePicker: UIDatePicker?
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        // select custom handeler for datepicker
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        // set minimum date
        datePicker?.minimumDate = Calendar.current.date(byAdding: .year, value: -120, to: Date())
        // set maximum date
        datePicker?.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(guestureRecognizer:)))
        
        view.addGestureRecognizer(tapGuesture)
        inputDatePicker.inputView = datePicker
    }
    
    @objc func viewTapped(guestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    //MARK: ACTIONS
    @objc func dateChanged( datePicker: UIDatePicker) {
        
        // selected date
        let dateFor = DateFormatter()
        dateFor.dateFormat = "MM/dd/yyyy"
        
        dob = dateFor.string(from: datePicker.date)
        inputDatePicker.text = dob
        
        let gregorian = Calendar(identifier: .gregorian)
        let ageComponents = gregorian.dateComponents([.year], from: datePicker.date, to: Date())
        let agemonthComponents = gregorian.dateComponents([.month], from: datePicker.date, to: Date())
        let age_years = ageComponents.year!
        let month:Double = Double(agemonthComponents.month!)
        
        print("Age is \(age_years) and month is\(month)")
        var newage = month/12
        print(newage.rounded()  )
        age = Double(month / 12).rounded()
        
        if(age_years < 0 || month < 0){
            print("error message")
            return
        }
        
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let switchPostion:Bool = travelled.isOn
        nameOfPatient = patient_name.text!
        var title_q = ""
        var message_q = ""
        print("IN SUBMIT BUTTON")
        print(switchPostion)
        print(age)
        print(nameOfPatient)
        
        if(nameOfPatient.isEmpty || age <= 0.0){
            if(nameOfPatient.isEmpty){
                title_q = "Unfilled information"
                message_q = "Please fill patient name first.\n It should not be empty."
            }else if( age <= 0.0){
                title_q = "Incorrect Information !"
                message_q = "Please select appropriate birth date."
            }
            let alertBox = UIAlertController(
                title: "\(title_q)",
                message: "\(message_q)",
                preferredStyle: .alert)
            
            alertBox.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertBox, animated: true)
            return
        }
        if(switchPostion == true){
            priority = 1
        }
        if(switchPostion == true && age > 65.0){
            priority = 3
        }else if(switchPostion == false && age > 65.0){
            priority = 2
        }else if(switchPostion == false && age < 65.0){
            priority = 0
        }
        //  print("priority is \(priority)")
       // sortedPatient = Global.sharedInstance.addedItemArray
        
        let patinetData:Patients = Patients(p_name: nameOfPatient, travel_did: switchPostion, ageOfp: age, priorityOfp: priority)
        if(priority != 0){
            sortedPatient.append(patinetData)
        }else{
            TestNotRequire.append(patinetData)
        }
        
        sortedPatient = sortedPatient.sorted(by: { $0.priorityOf > $1.priorityOf })
        // print(sortedPatient)
        
        
        
        for i in 0..<sortedPatient.count{
            
            print("\(sortedPatient[i].patient_name) and  \(sortedPatient[i].age) and  \(sortedPatient[i].travel) and \(sortedPatient[i].priorityOf)")
            
            
        }
        
        for j in 0..<sortedPatient.count{
            if(sortedPatient[j].patient_name == nameOfPatient &&
                sortedPatient[j].age == age &&
                sortedPatient[j].travel == switchPostion &&
                sortedPatient[j].priorityOf == priority){
                waiting_number = (j+1)
                print("Waitng number is \(j+1)")
                print("patient name\(sortedPatient[j].patient_name)")
            }
            
        }
        
        patient_name.text = ""
        travelled.isOn = false
        inputDatePicker.text = ""
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // For patient infomation page
        let PatientNumber_priority = storyBoard.instantiateViewController(withIdentifier: "PatientNumber_priorityViewControl")as! PatientNumber_priorityViewControl
        
        PatientNumber_priority.patient_name = nameOfPatient
        PatientNumber_priority.patient_age = age
        PatientNumber_priority.patient_priority = priority
        PatientNumber_priority.patient_waitng_number = waiting_number
        self.navigationController?.pushViewController(PatientNumber_priority, animated: true)
        
        
        //  NSUserDefaults.standardUserDefaults().objectForKey("key")
        
        let secondTab = self.tabBarController?.viewControllers![1] as! WaitngViewController
        secondTab.SortedArrayOfPatient = sortedPatient
        
        let thirdTab = self.tabBarController?.viewControllers![2] as! testNotRequiredViewContoller
        thirdTab.SortedArrayOfNoTestPatient = TestNotRequire
        
        
        
        
        
    }
    

}

