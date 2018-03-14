//
//  CustomerVC.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/14.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift

class CustomerVC: BaseVC {

    var customers: Results<CustomerData>!
    var cartes: Results<CarteData>!
    
    var selectedIndexPath: NSIndexPath?
    var cellSelectedColor = UIColor(red: 188.0/255.0, green: 237.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    var customerDay = [CustomerData]()
    var pass_data_callback : (([String : Any])->())?
    
    @IBOutlet weak var tblCustomer: UITableView!
    @IBOutlet weak var lblCusTotal: UILabel!
    @IBOutlet weak var lblCus: UILabel!
    @IBOutlet weak var lblCusGenre: UILabel!
    @IBOutlet weak var lblCusID: UILabel!
    @IBOutlet weak var lblCusBirth: UILabel!
    @IBOutlet weak var lblCusLstCome: UILabel!
    @IBOutlet weak var imvCus: UIImageView!
    @IBOutlet weak var tfCusNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCustomer.delegate = self
        tblCustomer.dataSource = self

        let realm = RealmServices.shared.realm
        customers = realm.objects(CustomerData.self)
        cartes = realm.objects(CarteData.self)
        deleteCarteData()
    }
    
    func deleteCarteData() {
        let realm = RealmServices.shared.realm
        let result = realm.objects(CarteData.self)
        do {
            try realm.write {
                realm.delete(result)
            }
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if GlobalVariables.sharedManager.cusDisplayByDay == true {
            customerDay.removeAll()
            setupCustomerByDay()
            updateUITop(index: 0)
            tblCustomer.reloadData()
        } else {
            setupUI()
            tblCustomer.reloadData()
        }
        
        if (pass_data_callback != nil){
            print("in so index \(GlobalVariables.sharedManager.cellIndex)")
            let customerID = customers[GlobalVariables.sharedManager.cellIndex].cusID
            pass_data_callback!(["cusID":customerID])
        }
    }
    
    func setupCustomerByDay() {
        for (index,element) in GlobalVariables.sharedManager.cusDataDisplay.enumerated() {
            let customer = CustomerData()
            customer.cusName = customers[element].cusName
            customer.cusID = customers[element].cusID
            customer.cusSex = customers[element].cusSex
            customer.cusBirth = customers[element].cusBirth
            customer.cusImage = customers[element].cusImage
            customer.cusSecret = customers[element].cusSecret
            customer.cusLstCome = customers[element].cusLstCome
            customer.cusMailOpen = customers[element].cusMailOpen
            customer.cusMailInbox = customers[element].cusMailInbox
            customer.cusMailError = customers[element].cusMailError
            customer.cusMailUnopen = customers[element].cusMailUnopen
            customer.cusRegisterDate = customers[element].cusRegisterDate
            customer.userID = customers[element].userID
            customer.cusNote = customers[element].cusNote
            customerDay.append(customer)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func updateUITop(index: Int){
        DispatchQueue.main.async {
            if GlobalVariables.sharedManager.cusDisplayByDay == true {
                self.lblCus.text = self.customerDay[index].cusName + "様"
                self.lblCusID.text = "ID : " + self.customerDay[index].cusID
                self.lblCusGenre.text = self.customerDay[index].cusSex
                self.lblCusBirth.text = self.customerDay[index].cusBirth
                self.lblCusLstCome.text = "最新来店日　:" + self.customerDay[index].cusLstCome
                self.tfCusNote.text = self.customerDay[index].cusNote
                
                if let url = URL.init(string: self.customerDay[index].cusImage) {
                    self.imvCus.downloadedFrom(url: url)
                    self.imvCus.roundImage(with: self.imvCus)
                }
            } else {
                self.lblCus.text = self.customers[index].cusName + "様"
                self.lblCusID.text = "ID : " + self.customers[index].cusID
                self.lblCusGenre.text = self.customers[index].cusSex
                self.lblCusBirth.text = self.customers[index].cusBirth
                self.lblCusLstCome.text = "最新来店日　:" + self.customers[index].cusLstCome
                self.tfCusNote.text = self.customers[index].cusNote
                
                if let url = URL.init(string: self.customers[index].cusImage) {
                    self.imvCus.downloadedFrom(url: url)
                    self.imvCus.roundImage(with: self.imvCus)
                }
            }
            
        }
    }

    func setupUI() {
        lblCusTotal.text = "全　: \(customers.count)件"
        
        // Calling manually to the delegate method
        let indexPath = IndexPath(row: 0, section: 0)
        tblCustomer.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        tableView(tblCustomer, didSelectRowAt: indexPath)

//        tblCustomer.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        updateUITop(index: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addNewCustomerPressed(_ sender: Any) {
        
    }
    
    @IBAction func sortIndexPressed(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.tblCustomer.numberOfSections
            let numberOfRows = self.tblCustomer.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.tblCustomer.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        
    }
    
    @IBAction func editPressed(_ sender: Any) {
        
    }
}

extension CustomerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell") as? CustomerCell else
        { return UITableViewCell() }
        
        if GlobalVariables.sharedManager.cusDisplayByDay == true {
            let customerCell = customerDay[indexPath.row]
            cell.configure(with: customerCell)
        } else {
            let customerCell = customers[indexPath.row]
            cell.configure(with: customerCell)
        }
   
        if self.selectedIndexPath == indexPath as NSIndexPath {
            cell.contentView.backgroundColor = self.cellSelectedColor
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if GlobalVariables.sharedManager.cusDisplayByDay == true {
            return customerDay.count
        }
        else {
            return customers.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(String(describing: selectedIndexPath?.row)) indexpath \(String(indexPath.row))")
        if selectedIndexPath == indexPath as NSIndexPath {
            //selected same cell -> deselect
            selectedIndexPath = indexPath as NSIndexPath
        }else{
            let oldSelectedIndexPath = selectedIndexPath
            selectedIndexPath = indexPath as NSIndexPath
            // refresh old cell to clear old selection indicators
            if let previousSelectedIndexPath = oldSelectedIndexPath {
                if let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath as IndexPath) {
                    self.configure(cell: previousSelectedCell as! CustomerCell, forRowAtIndexPath: previousSelectedIndexPath as IndexPath)
                }
            }
        }
        self.updateUITop(index: indexPath.row)
        let selectedCell = tableView.cellForRow(at: indexPath)
        if selectedCell != nil {
            configure(cell: selectedCell as! CustomerCell, forRowAtIndexPath: indexPath)
        }
        
        GlobalVariables.sharedManager.cellIndex = indexPath.row
        let customerID = customers[GlobalVariables.sharedManager.cellIndex].cusID
        pass_data_callback!(["cusID":customerID])
    }
    
    func configure(cell: CustomerCell,forRowAtIndexPath indexPath:IndexPath) {
        DispatchQueue.main.async {
            if self.selectedIndexPath == indexPath as NSIndexPath {
                cell.contentView.backgroundColor = self.cellSelectedColor
            }else{
                cell.contentView.backgroundColor = UIColor.clear
            }
        }
    }
}
