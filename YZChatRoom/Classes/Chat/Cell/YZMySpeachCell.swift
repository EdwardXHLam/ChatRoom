//
//  YZMySpeachCell.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/24.
//

import UIKit

class YZMySpeachCell: YZBaseTableViewCell {
    
    var messageInfo: messageModel? {
        
        didSet {
            
            messageLabel.text = messageInfo?.msg
        }
    }
    
    private lazy var myIconView: UIImageView = {
        
        let myIconView = UIImageView()
        myIconView.contentMode = .scaleAspectFill
        myIconView.image = getImage("ic_mine_head_teather")
        contentView.addSubview(myIconView)
        return myIconView
    }()
    
    private lazy var messageLabel: UILabel = {

        let messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        contentView.addSubview(messageLabel)
        return messageLabel
    }()

    private lazy var bubbleImgView: UIImageView = {
        
        let bubbleImgView = UIImageView()
        bubbleImgView.contentMode = .scaleToFill
        bubbleImgView.image = getImage("ic_bubble_left")
        contentView.addSubview(bubbleImgView)
        return bubbleImgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        myIconView.isHidden = false
        bubbleImgView.isHidden = false
        messageLabel.isHidden = false
        reConfigUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reConfigUI() {
        
        myIconView.snp_makeConstraints { make in
            
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }

        messageLabel.snp_makeConstraints { make in
            
            make.right.equalTo(myIconView.snp_left).offset(-15)
            
            make.top.equalTo(myIconView).offset(10)

            make.width.lessThanOrEqualTo(YZPage_Screen_Width - CGFloat(150))
            
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        bubbleImgView.snp_makeConstraints { make in
            
            make.right.equalTo(myIconView.snp_left).offset(-5)
            
            make.top.equalTo(messageLabel).offset(-5)

            make.left.equalTo(messageLabel.snp_left).offset(-5)
            
            make.bottom.equalTo(self.contentView).offset(-5)
        }
        
    }
}


class YZOthersSpeachCell: YZBaseTableViewCell {
    
    var messageInfo: messageModel? {
        
        didSet {
            
            var phoneModel = ""
            
            var userId = ""
            
            if let phone = messageInfo?.phoneModel, !phone.isBlank {
                
                phoneModel = phone
            }
            
            if let uid = messageInfo?.userId, !uid.isBlank {
                
                userId = uid
            }
            
            senderIdLabel.text = "\(phoneModel)用户ID:\(userId)"
            
            messageLabel.text = messageInfo?.msg
        }
    }
    
    private lazy var myIconView: UIImageView = {
        
        let myIconView = UIImageView()
        myIconView.contentMode = .scaleAspectFill
        myIconView.image = getImage("ic_mine_head_woman")
        contentView.addSubview(myIconView)
        return myIconView
    }()
    
    private lazy var senderIdLabel: UILabel = {

        let senderIdLabel = UILabel()
        senderIdLabel.font = UIFont.systemFont(ofSize: 12)
        senderIdLabel.textColor = .black
        contentView.addSubview(senderIdLabel)
        return senderIdLabel
    }()
    
    private lazy var messageLabel: UILabel = {

        let messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        contentView.addSubview(messageLabel)
        return messageLabel
    }()
    
    private lazy var bubbleImgView: UIImageView = {
        
        let bubbleImgView = UIImageView()
        bubbleImgView.contentMode = .scaleToFill
        bubbleImgView.image = getImage("ic_bubble_right")
        contentView.addSubview(bubbleImgView)
        return bubbleImgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        myIconView.isHidden = false
        senderIdLabel.isHidden = false
        bubbleImgView.isHidden = false
        messageLabel.isHidden = false
        reConfigUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reConfigUI() {
        
        myIconView.snp_makeConstraints { make in
            
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        senderIdLabel.snp_makeConstraints { make in
            
            make.left.equalTo(myIconView.snp_right).offset(10)
            make.top.equalTo(myIconView)
        }
        
        messageLabel.snp_makeConstraints { make in
            
            make.left.equalTo(myIconView.snp_right).offset(15)
            
            make.top.equalTo(senderIdLabel.snp_bottom).offset(10)

            make.width.lessThanOrEqualTo(YZPage_Screen_Width - CGFloat(150))
            
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        bubbleImgView.snp_makeConstraints { make in
            
            make.left.equalTo(messageLabel).offset(-10)
            
            make.top.equalTo(messageLabel).offset(-5)

            make.right.equalTo(messageLabel).offset(5)
            
            make.bottom.equalTo(self.contentView).offset(-5)
        }
    }
}
