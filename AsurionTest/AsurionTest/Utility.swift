//
//  Utility.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import Foundation
import UIKit

class Utility {
    
    func getTodayString() -> (String, Int?){
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second, .weekday], from: date)
        let hour = components.hour
        let minute = components.minute
        let weekDay = components.weekday
        let today_string = String(hour!)  + ":" + String(minute!)
        
        return (today_string, weekDay)
    }
}

class LazyImageView : UIImageView {
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    func loadImage(imageURL: URL, placeHolderImage: String){
        self.image = UIImage(named: placeHolderImage)
        
        if let cachedImage = imageCache.object(forKey: imageURL as AnyObject) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self.image = image
                    }
                }
            }
        }
        
    }
}

extension String {
    func convertDateFromString() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let convertedDate = formatter.date(from: self) ?? Date()
        return convertedDate
    }
}

extension ViewController {
    func showDefaultAlertwith(errorTitle: String, message: String) {
        let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
