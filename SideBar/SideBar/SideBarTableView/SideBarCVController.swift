//
//  SideBarCVController.swift
//  SideBar
//
//  Created by Oğuz Canbaz on 1.06.2024.
//

import UIKit
import SnapKit

class SideBarCVController: UIViewController {
    
    // MARK: -- Properties
    
    var data: [String] = []
    var subviewWidth:CGFloat = 0
    
    // MARK: -- Components
    
    private lazy var mainView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var subView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        let cell = UINib(nibName: "SideBarCVCell", bundle: nil)
        cv.register(cell, forCellWithReuseIdentifier: "SideBarCVCell")
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        subviewWidth = self.view.frame.size.width * 0.7
        setupView()
        addGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sideBarPresent()
    }
    
    // MARK: -- Functions
    
    private func addGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mainView.addGestureRecognizer(tapGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeftGesture.direction = .left
        subView.addGestureRecognizer(swipeLeftGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        sideBarDismiss()
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        sideBarDismiss()
    }
    
    func sideBarPresent(){
        
        subView.snp.updateConstraints { make in
            make.leading.equalTo(self.view.snp.leading).offset(-subviewWidth)
        }
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.subView.snp.updateConstraints { make in
                make.leading.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func sideBarDismiss(){
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.subView.snp.updateConstraints { (make) in
                make.leading.equalTo(self.view.snp.leading).offset(-self.subviewWidth)
            }
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupView() {
        self.view.addSubview(mainView)
        self.view.addSubview(subView)
        subView.addSubview(collectionView)
        setupLayout()
    }
    
    func setupLayout() {
        
        mainView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        subView.snp.makeConstraints({make in
            make.leading.bottom.top.equalToSuperview()
            make.width.equalTo(subviewWidth)
        })
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: -- Extensions

extension SideBarCVController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SideBarCVCell", for: indexPath) as! SideBarCVCell
        cell.label.text = data[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = collectionViewWidth
        let cellHeight = cellWidth/6
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

