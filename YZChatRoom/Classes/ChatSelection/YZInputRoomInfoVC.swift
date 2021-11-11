//
//  YZInputRoomInfoVC.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/24.
//

import UIKit

class YZInputRoomInfoVC: YZBaseViewController {
    
    var isPrivateChat = true
    
    private lazy var roomDesLabel: UILabel = {
        
        let roomDesLabel = UILabel()
        
        view.addSubview(roomDesLabel)
        
        return roomDesLabel
    }()
    
    private lazy var roomTextField: UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = .lightGray
        
        textField.text = "100"
        
        textField.BorderRadiusToView(radius: 5, width: 1, color: .lightGray)
        
        textField.leftViewMode = .always
        
        textField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        view.addSubview(textField)
        
        return textField
    }()
    
    private lazy var userIdLabel: UILabel = {
        
        let userIdLabel = UILabel()
        
        view.addSubview(userIdLabel)
        
        return userIdLabel
    }()
    
    private lazy var userIdTextField: UITextField = {
        
        let userIdTextField = UITextField()
        
        userIdTextField.backgroundColor = .lightGray
        
        userIdTextField.text = "144"
        
        userIdTextField.BorderRadiusToView(radius: 5, width: 1, color: .lightGray)
        
        userIdTextField.leftViewMode = .always
        
        userIdTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        view.addSubview(userIdTextField)
        
        return userIdTextField
    }()
    
    //我的ID
    private lazy var myuserIdLabel: UILabel = {
        
        let myuserIdLabel = UILabel()
        
        myuserIdLabel.text = "我的ID："
        
        view.addSubview(myuserIdLabel)
        
        return myuserIdLabel
    }()
    
    private lazy var myUserIdTextField: UITextField = {
        
        let myUserIdTextField = UITextField()
        
        myUserIdTextField.backgroundColor = .lightGray
        
        myUserIdTextField.text = "188"
        
        myUserIdTextField.BorderRadiusToView(radius: 5, width: 1, color: .lightGray)
        
        myUserIdTextField.leftViewMode = .always
        
        myUserIdTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        view.addSubview(myUserIdTextField)
        
        return myUserIdTextField
    }()
    
    private lazy var jumpBtn: UIButton = {
        
        let jumpBtn = UIButton()
        
        jumpBtn.setTitle("进入聊天室", for: .normal)
        
        jumpBtn.backgroundColor = .red
        
        jumpBtn.BorderRadiusToView(radius: 5, width: 1, color: .red)
        
        jumpBtn.addTarget(self, action: #selector(messageRoomAction), for: .touchUpInside)
        
        view.addSubview(jumpBtn)
        
        return jumpBtn
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = isPrivateChat ? "私聊" : "群聊"
        
        userIdLabel.text = isPrivateChat ? "指定用户ID：" : ""
        
        roomDesLabel.text = isPrivateChat ? "" : "房间号："
    }
    
    override func configUI() {
        
        super.configUI()
        
        roomDesLabel.snp_makeConstraints { make in
            
            make.top.equalTo(self.view).offset(isPrivateChat ? 0 : 20)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
        }
        
        roomTextField.snp_makeConstraints { make in
            
            make.top.equalTo(roomDesLabel.snp_bottom).offset(isPrivateChat ? 0 : 20)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
            make.height.equalTo(isPrivateChat ? 0 : 50)
            
        }
        
        userIdLabel.snp_makeConstraints { make in
            
            make.top.equalTo(roomTextField.snp_bottom).offset(isPrivateChat ? 20 : 0)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
        }
        
        userIdTextField.snp_makeConstraints { make in
            
            make.top.equalTo(userIdLabel.snp_bottom).offset(isPrivateChat ? 20 : 0)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
            make.height.equalTo(isPrivateChat ? 50 : 0)
            
        }
        
        myuserIdLabel.snp_makeConstraints { make in
            
            make.top.equalTo(userIdTextField.snp_bottom).offset(20)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
        }
        
        myUserIdTextField.snp_makeConstraints { make in
            
            make.top.equalTo(myuserIdLabel.snp_bottom).offset(20)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
            make.height.equalTo(50)
        }
        
        jumpBtn.snp_makeConstraints { make in
            
            make.top.equalTo(myUserIdTextField.snp_bottom).offset(20)
            
            make.left.equalTo(self.view).offset(10)
            
            make.right.equalTo(self.view).offset(-10)
            
            make.height.equalTo(50)
            
        }
    }
}


extension YZInputRoomInfoVC {
    
    @objc private func messageRoomAction() {
        
        if let otherId = userIdTextField.text, !otherId.isBlank,let currentID = myUserIdTextField.text, !currentID.isBlank,let roomId = roomTextField.text,!roomId.isBlank {
            
            YZSocketIOManager.shared.basicSettings(roomId: isPrivateChat ? nil : roomId, currentUserId: currentID, otherUserId: isPrivateChat ? otherId : nil, isPrivate: isPrivateChat)
            
            self.navigationController?.pushViewController(YZChatMessageRoomVC(), animated: true)
        } else {
            
            YZMBProgressHud.showTextHudTips(message: "请填写信息", isTranslucent: true)
        }
    }
}

