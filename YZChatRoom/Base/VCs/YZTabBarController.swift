//
//  UTabBarController.swift
// 
//
//  Created by YZ-LXH on 2021/2/19.
//

import UIKit

class YZTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        /// 首页
        let onePageVC = YZChatRoomHomeVC()
        
        addChildViewController(onePageVC,
                               title: "首页",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home_S"))

    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(YZNavigationController(rootViewController: childController))
    }
    
}

extension YZTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
