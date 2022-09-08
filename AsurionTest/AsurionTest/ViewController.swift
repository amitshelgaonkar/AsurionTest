//
//  ViewController.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import UIKit

class ViewController: UIViewController {
    var controllerViewModel: ViewControllerViewModel?
    @IBOutlet weak var petTableView: UITableView?
    @IBOutlet var callButton: UIButton?
    @IBOutlet var chatButton: UIButton?
    @IBOutlet var scheduleLable: UILabel?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    @IBOutlet var contactStackViewConstraints: NSLayoutConstraint?
    
    var petsArray: [Pet]?
    var configSettings: Settings?
    var contentUrl: String?
    var petName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        controllerViewModel = ViewControllerViewModel()
        activityIndicator?.startAnimating()
        fetchDataFromAPI()
    }
    
    func setScheduleTiming() {
        
        DispatchQueue.main.async {
            self.callButton?.isHidden = !(self.configSettings?.isCallEnabled ?? false)
            self.chatButton?.isHidden = !(self.configSettings?.isChatEnabled ?? false)
            self.scheduleLable?.text = "\(officeHoursString) : \(self.configSettings?.workHours ?? "")"
            self.scheduleLable?.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBAction func clickonCallButton() {
        if self.controllerViewModel?.checkOfficehoursTiming(workingHours: self.configSettings?.workHours, todaysDateString: Utility().getTodayString().0, WeekDay: Utility().getTodayString().1) ?? false {
            showDefaultAlertwith(errorTitle: "", message: alertMessageinOfficeHours)
        } else {
            showDefaultAlertwith(errorTitle: "", message: alertMessageAfterOfficeHours)
        }
    }
    
    @IBAction func clickonChatButton() {
        if self.controllerViewModel?.checkOfficehoursTiming(workingHours: self.configSettings?.workHours, todaysDateString: Utility().getTodayString().0, WeekDay: Utility().getTodayString().1) ?? false {
            showDefaultAlertwith(errorTitle: "", message: alertMessageinOfficeHours)
        } else {
            showDefaultAlertwith(errorTitle: "", message: alertMessageAfterOfficeHours)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webViewController = segue.destination as? WebViewController else { return }
        webViewController.contentURL = contentUrl
        webViewController.petName = petName
    }
}

extension ViewController {
    
    func fetchDataFromAPI() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        controllerViewModel?.getConfigAPIData(param: nil, completion: { [weak self] config, error in
            guard let self = self else { return }
            if error == nil {
                self.configSettings = config?.settings
            } else {
                DispatchQueue.main.async {
                    self.showDefaultAlertwith(errorTitle: errorTitle, message: errorMessage)
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        controllerViewModel?.getPetAPIData(param: nil, completion: { [weak self] petData, error in
            guard let self = self else { return }
            if error == nil {
                self.petsArray = petData?.pets
            } else {
                DispatchQueue.main.async {
                    self.showDefaultAlertwith(errorTitle: errorTitle, message: errorMessage)
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.activityIndicator?.stopAnimating()
            self.setScheduleTiming()
            self.petTableView?.reloadData()
        }
    }
}

