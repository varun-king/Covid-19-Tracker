//
// Student Name : VARUN DINESHBHAI PATEL
// Student ID : 101275495

//  Patients.swift
//  NewVirus
//
//  Created by apple on 4/12/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

class Patients{
    
    
    var patient_name:String = "";
    var travel:Bool = true;
    var age:Double = 0.0;
    var priorityOf:Int = 1;
    
    
    
    init(p_name:String, travel_did:Bool, ageOfp:Double, priorityOfp:Int) {
        self.patient_name = p_name
        self.travel = travel_did
        self.age = ageOfp
        self.priorityOf = priorityOfp
    }
    
    
}
