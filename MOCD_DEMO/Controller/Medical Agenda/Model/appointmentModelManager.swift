//
//  appointmentModelManager.swift
//  SmartAgenda
//
//  Created by indianic on 13/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class appointmentModelManager: NSObject {

    
    // MARK: Shared UserInfoManager
    class var sharedInstance: appointmentModelManager {
        struct Static {
            static var instance = appointmentModelManager()
        }
        return Static.instance
    }

    
    // Get Appointment Data
    func getAppointmentData(completion: (([getAppointmentReminder]) -> Void)) {
        
        completion(appointmentModel().GetAllAppointmentList())
    }
    
    func deleteAppointmentData(deleteID: Int, complition: @escaping ((Bool)  -> Void)) {
        
        appointmentModel().deleteAppointment(deleteID: deleteID) { (result: Bool) in
            complition(result)
        }
    }
    
}
