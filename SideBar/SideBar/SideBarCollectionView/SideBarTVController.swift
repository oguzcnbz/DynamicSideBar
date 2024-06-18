//
//  SideBarTVController.swift
//  SideBar
//
//  Created by Oğuz Canbaz on 1.06.2024.
//

import UIKit
import SnapKit

class SideBarTVController: UIViewController {
    
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
    
    private lazy var tableView: UITableView = {
        let tw = UITableView()
        tw.backgroundColor = .clear
        tw.register(SideBarTVCell.self, forCellReuseIdentifier: "SideBarTVCell")
        tw.dataSource = self
        tw.delegate = self
        return tw
    }()
    
    // MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        subviewWidth = self.view.frame.size.width * 0.7
        setupView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mainView.addGestureRecognizer(tapGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeftGesture.direction = .left
        subView.addGestureRecognizer(swipeLeftGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sideBarPresent()
    }
    
    // MARK: -- Functions
    
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
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        sideBarDismiss()
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        sideBarDismiss()
    }
    
    func setupView() {
        self.view.addSubview(mainView)
        self.view.addSubview(subView)
        subView.addSubview(tableView)
        setupLayout()
    }
    
    func setupLayout() {
        
        mainView.snp.makeConstraints({sv in
            sv.top.equalToSuperview()
            sv.leading.equalToSuperview()
            sv.trailing.equalToSuperview()
            sv.bottom.equalToSuperview()
        })
        
        subView.snp.makeConstraints({sv in
            sv.leading.equalToSuperview()
            sv.bottom.equalToSuperview()
            sv.top.equalToSuperview()
            sv.width.equalTo(subviewWidth)
        })
        
        tableView.snp.makeConstraints { tw in
            tw.edges.equalToSuperview()
        }
    }
}

// MARK: -- Extensions

extension SideBarTVController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideBarTVCell", for: indexPath) as? SideBarTVCell else { return UITableViewCell() }
        cell.label.text = data[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
}
