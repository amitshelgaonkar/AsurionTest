//
//  ViewController+Extension.swift
//  AsurionTest
//
//  Created by amit.shelgaonkar on 29/08/22.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? PetTableCell else {
            return UITableViewCell()
        }
        let petData = petsArray?[indexPath.row]
        cell.petNameLable?.text = petData?.title ?? ""
        
        guard let imageURL = URL(string: petData?.imageURL ?? "") else {
            return cell
        }
        cell.petImageView?.loadImage(imageURL:imageURL, placeHolderImage: "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petData = petsArray?[indexPath.row]
        guard let ContentURL = petData?.contentURL, let pet_Name = petData?.title else {
            return
        }
        contentUrl = ContentURL
        petName = pet_Name
        self.performSegue(withIdentifier: "webviewController", sender: nil)
    }
}



