//
//  CustomerPageVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/15.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class CustomerPageVC: BasePageVC {
    var customerVC : CustomerVC?
    var carteVC : CarteVC?
    var selectedCarteVC : SelectedCarteVC?
    var data :String = ""
    
    lazy var orderedViewControllers: [UIViewController] = {
        customerVC = self.newVc(viewController: "CustomerVC") as? CustomerVC
        customerVC?.pass_data_callback = {
            pass_data in
            self.carteVC?.receive_data = pass_data
        }
        carteVC = self.newVc(viewController: "CarteVC") as? CarteVC
        carteVC?.pass_data_callback = {
            pass_data in
            self.selectedCarteVC?.receive_data = pass_data
        }
        selectedCarteVC = self.newVc(viewController: "SelectedCarteVC") as? SelectedCarteVC
        return [customerVC!,
                carteVC!,
                selectedCarteVC!]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}

// MARK: PageView Delegate
extension CustomerPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        // Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            //            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            //            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}
