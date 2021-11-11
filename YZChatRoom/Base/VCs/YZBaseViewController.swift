//
//  UBaseViewController.swift
//  
//
//  Created by YZ-LXH on 2021/2/19.
//

import UIKit
import SnapKit
import Then
import Reusable
import Kingfisher

class YZBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.background
//        if #available(iOS 11.0, *) {
//            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func configUI() {}
    
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.white)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
//            if navi.viewControllers.count > 1 {
//                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "white_JumpBack"),
//                                                                   target: self,
//                                                                   action: #selector(pressBack))
//            }
        }
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension YZBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
}
