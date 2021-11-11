//
//  YZChatRoomHomeVC.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/24.
//

import UIKit
import SnapKit

class YZChatRoomHomeVC: YZBaseViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let singleChatBtn = UIButton()
        
        singleChatBtn.tag = 340
        
        singleChatBtn.setTitle("单聊", for: .normal)
        
        singleChatBtn.backgroundColor = .blue
        
        singleChatBtn.addTarget(self, action: #selector(singleChatAction), for: .touchUpInside)
        
        view.addSubview(singleChatBtn)
        
        singleChatBtn.snp_makeConstraints { make in
            
            make.top.equalTo(self.view).offset(YZPage_NavBar_Height)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
            make.height.equalTo(50)
        }
        
        let groupChatBtn = UIButton()
        
        groupChatBtn.tag = 341
        
        groupChatBtn.setTitle("群聊", for: .normal)
        
        groupChatBtn.backgroundColor = .blue
        
        groupChatBtn.addTarget(self, action: #selector(singleChatAction), for: .touchUpInside)
        
        view.addSubview(groupChatBtn)
        
        groupChatBtn.snp_makeConstraints { make in
            
            make.top.equalTo(singleChatBtn.snp_bottom).offset(50)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
            make.height.equalTo(50)
        }
        
    }
}

extension YZChatRoomHomeVC {
    
    @objc private func singleChatAction(sender: UIButton) {
        
        let roomInfoVC = YZInputRoomInfoVC()
        
        roomInfoVC.isPrivateChat = sender.tag == 340
        
        self.navigationController?.pushViewController(roomInfoVC, animated: true)
    }
}
