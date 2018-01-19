//
//  HomeVC.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/15.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var lblCusRegisterToday: RoundLabelCorner!
    @IBOutlet weak var lblNotificationNew: RoundLabelCorner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = createDateTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDateTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ホーム　yyyy/MM/dd "
        let weekday = Calendar.current.component(.weekday, from: date)
        let result = formatter.string(from: date)
        return result + checkWeekDay(weekday: weekday)
    }
    
    func checkWeekDay(weekday:Int) -> String{
        switch weekday {
        case 1:
            return "（日）"
        case 2:
            return "（月）"
        case 3:
            return "（火）"
        case 4:
            return "（水）"
        case 5:
            return "（木）"
        case 6:
            return "（金）"
        case 7:
            return "（土）"
        default:
            return "Error"
        }
    }

    @IBAction func searchCustomerPressed(_ sender: Any) {
        mainTabbarController?.selectedIndex = 1
    }
    
    @IBAction func listCustomerTodayPressed(_ sender: Any) {
        mainTabbarController?.selectedIndex = 1
    }

    @IBAction func registerCustomerPressed(_ sender: Any) {
        
    }
    
    @IBAction func appNotifyPressed(_ sender: Any) {
        
    }
    
}
