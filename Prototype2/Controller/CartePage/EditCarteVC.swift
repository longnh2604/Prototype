//
//  EditCarteVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift
import Gallery
import AVFoundation

class EditCarteVC: UIViewController, GalleryControllerDelegate {

    @IBOutlet weak var imvCus: UIImageView!
    @IBOutlet weak var lblCusName: UILabel!
    @IBOutlet weak var lblLstCome: UILabel!
    @IBOutlet weak var lblMemo: UILabel!
    @IBOutlet weak var lblHobby: UILabel!
    @IBOutlet weak var lblBloodType: UILabel!
    @IBOutlet weak var lblCusBirth: UILabel!
    @IBOutlet weak var lblLstComeDay: UILabel!
    @IBOutlet weak var lblCusID: UILabel!
    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var tfMemo1: UITextView!
    @IBOutlet weak var tfMemo2: UITextView!
    @IBOutlet weak var tfMemo: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var receive_data : [String:Any]?
    var customers: Results<CustomerData>!
    var cartes: Results<CarteData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupUI()
        
        print("Receive data from CustomerVC \(String(describing: receive_data ?? nil))")
        
    }
    
    func setupUI() {
        let realm = RealmServices.shared.realm
        customers = realm.objects(CustomerData.self)
        cartes = realm.objects(CarteData.self)
        print(cartes)
        print(cartes[GlobalVariables.sharedManager.cellCarteIndex])
        print(cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages.count)
        
        lblCusName.text = customers[GlobalVariables.sharedManager.cellIndex].cusName
        lblCusID.text = customers[GlobalVariables.sharedManager.cellIndex].cusID
        lblCusBirth.text = customers[GlobalVariables.sharedManager.cellIndex].cusBirth
        lblLstCome.text = customers[GlobalVariables.sharedManager.cellIndex].cusLstCome
        lblMemo.text = customers[GlobalVariables.sharedManager.cellIndex].cusMemo
        lblBloodType.text = customers[GlobalVariables.sharedManager.cellIndex].cusBloodType
        lblHobby.text = customers[GlobalVariables.sharedManager.cellIndex].cusHobby
        tfNote.text = customers[GlobalVariables.sharedManager.cellIndex].cusNote
        
        if let url = URL.init(string: self.customers[GlobalVariables.sharedManager.cellIndex].cusImage) {
            self.imvCus.downloadedFrom(url: url)
            self.imvCus.roundImage(with: self.imvCus)
        }
        
        tfMemo.text = cartes[GlobalVariables.sharedManager.cellCarteIndex].carteMemo
        tfMemo1.text = cartes[GlobalVariables.sharedManager.cellCarteIndex].carteMemo1
        tfMemo2.text = cartes[GlobalVariables.sharedManager.cellCarteIndex].carteMemo2
        lblLstComeDay.text = cartes[GlobalVariables.sharedManager.cellCarteIndex].cusLstCome
        
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCameraPressed(_ sender: Any) {
        let gallery = GalleryController()
        gallery.delegate = self
        self.present(gallery, animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]){
        
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video){
        
    }
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]){
        
    }
    func galleryControllerDidCancel(_ controller: GalleryController){
        controller.dismiss(animated: true, completion: nil)
    }
    
    func getThumbnailFrom(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
        
    }
}

extension EditCarteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCarteCollectionCell", for: indexPath) as! SelectedCarteCollectionCell
        print(cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages[indexPath.row])
        
        if let url = URL.init(string: cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages[indexPath.row]) {
            let imageExtensions = ["png", "jpg", "gif"]
            let pathExtention = url.pathExtension
            
                if imageExtensions.contains(pathExtention)
                {
                    //image
                    cell.imvCarte.downloadedFrom(url: url)
                }else
                {
//                    DispatchQueue.global().async {
//                        //movie
//                        let asset = AVAsset(url: url)
//                        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
//                        assetImgGenerate.appliesPreferredTrackTransform = true
//                        let time = CMTimeMake(1, 2)
//                        let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//                        if img != nil {
//                            let frameImg  = UIImage(cgImage: img!)
//                            DispatchQueue.main.async(execute: {
//                                cell.imvCarte = UIImageView(image: frameImg)
//                            })
//                        }
//                    }
                }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages.count
    }
}
