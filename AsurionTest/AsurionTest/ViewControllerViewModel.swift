//
//  ViewControllerViewModel.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import Foundation

struct ViewControllerViewModel {
    func getConfigAPIData(param: [String: Any]?, completion: @escaping (ConfigModel?, ServiceError?) -> ()) {
        let request = ConfigApiRequest()
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            guard let _ = error else {
                completion(model, nil)
                return
            }
            completion(nil, error)
        }
    }
    
    // Fetch Pet Data from the api
    //param: Request parameter for getting data from server
    //completion: Response Handler with PetModel and Service Error
    
    func getPetAPIData(param: [String: Any]?, completion: @escaping (PetModel?, ServiceError?) -> ()) {
        let request = PetApiRequest()
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            guard let _ = error else {
                completion(model, nil)
                return
            }
            completion(nil, error)
        }
    }
    
    // This Function is To check Office Hours with Week day and time logic with current day and time
    func checkOfficehoursTiming(workingHours: String?, todaysDateString: String?, WeekDay: Int?)-> Bool {
        guard let workingHours = workingHours, let todaysDateString = todaysDateString, let _ = WeekDay else {
            return false
        }
        let timeString = workingHours.components(separatedBy: CharacterSet.init(charactersIn: "0123456789:00 ").inverted).joined(separator: "")
        let stringArray = timeString.components(separatedBy: " ").filter({ $0 != "" })
        let startDate = (stringArray[0]).convertDateFromString()
        let endDate = (stringArray[1]).convertDateFromString()
        let todayDate = (todaysDateString).convertDateFromString()
        if (WeekDay != 1 && WeekDay != 7) && (todayDate > startDate && endDate > todayDate) {
            return true
        } else {
            return false
        }
    }
}

