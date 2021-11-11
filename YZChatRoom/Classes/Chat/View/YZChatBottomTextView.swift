//
//  YZChatBottomTextView.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/25.
//

import UIKit

class YZChatBottomTextView: YZBaseView {

    private lazy var chatTextView: UITextView = {
        let chatTextView = UITextView()
        chatTextView.font = getRegularFontSize(fontSize: 14)
        chatTextView.backgroundColor = .lightGray
        chatTextView.textColor = .black
        chatTextView.textContainer.lineFragmentPadding = 10
        chatTextView.BorderRadiusToView(radius: 5, width: 1, color: .lightGray)
        addSubview(chatTextView)
        return chatTextView
    }()
    
    private lazy var sendMessageBtn: UIButton = {
        let sendBtn = UIButton()
        sendBtn.titleLabel?.font = getRegularFontSize(fontSize: 14)
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.backgroundColor = .systemPink
        sendBtn.BorderRadiusToView(radius: 5, width: 1, color: .systemPink)
        sendBtn.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        addSubview(sendBtn)
        return sendBtn
    }()

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        sendMessageBtn.snp_makeConstraints { make in
            
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-5)
            make.top.equalTo(self).offset(5)
            make.width.equalTo(60)
        }
        
        chatTextView.snp_makeConstraints { make in
            
            make.left.equalTo(self).offset(20)
            make.right.equalTo(sendMessageBtn.snp_left).offset(-10)
            make.bottom.equalTo(self).offset(-5)
            make.top.equalTo(self).offset(5)
        }
    }

}

extension YZChatBottomTextView {
    
    @objc private func sendAction(sender: UIButton) {
        
        if let message = chatTextView.text, !message.isBlank {
            
            YZSocketIOManager.shared.sendPrivateMessages(message: message)
            
            chatTextView.text = ""
        } else {
            
            YZMBProgressHud.showTextHudTips(message: "请输入消息", isTranslucent: true)
            
        }
    }
}
