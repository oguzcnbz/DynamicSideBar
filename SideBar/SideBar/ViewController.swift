//
//  ViewController.swift
//  SideBar
//
//  Created by Oğuz Canbaz on 1.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -- Properties
    
    var sideBarCollectionViewController: SideBarCVController?
    var sideBarTableViewController: SideBarTVController?
    
    // MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: -- Functions
    
    @IBAction func openTVSideBar(_ sender: Any) {
        sideBarTableViewController = SideBarTVController()
        if let sideBarVC = sideBarTableViewController {
            sideBarTableViewController?.data = ["İşlemlerim","İşlemlerim","İşlemlerim","İşlemlerim"]
            sideBarTableViewController?.modalPresentationStyle = .overFullScreen
            present(sideBarVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func openCVSideBar(_ sender: Any) {
        sideBarCollectionViewController = SideBarCVController()
        if let sideBarVC = sideBarCollectionViewController {
            sideBarCollectionViewController?.data = ["İşlemlerim","İşlemlerim","İşlemlerim","İşlemlerim"]
            sideBarCollectionViewController?.modalPresentationStyle = .overFullScreen
            present(sideBarVC, animated: false, completion: nil)
        }
    }
}

