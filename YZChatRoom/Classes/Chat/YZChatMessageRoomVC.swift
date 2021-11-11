//
//  YZChatMessageRoomVC.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/24.
//

import UIKit

class YZChatMessageRoomVC: YZBaseViewController {
    
    var messageArrays = [messageModel]()
    
    private lazy var socketIOManager: YZSocketIOManager = {
     
        let socketIOManager = YZSocketIOManager.shared
        
        socketIOManager.callBackInfo = { [weak self] data,ack in
            
            if let actualData = data as? [messageModel] {
                
                self?.messageArrays.append(contentsOf: actualData)

                self?.refreshTableViewAction()
            }
        }
        
        socketIOManager.statusCallBackInfo = { [weak self] status in
            
            var title = ""
            
            switch status {
            case .connecting:
                title = "连接中...."
            case .disconnected:
                title = "连接已断开!"
            case .connected:
                title = "已连接"
            default:
                title = "未连接"
            }
            self?.title = title
        }
        
        return socketIOManager
    }()
 
    private lazy var chatRoomTableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.delegate = self
        tw.dataSource = self
        tw.separatorStyle = .none
        tw.backgroundColor = .lightGray
        tw.estimatedRowHeight = 50
        tw.rowHeight = UITableView.automaticDimension
        tw.register(cellType: YZMySpeachCell.self)
        tw.register(cellType: YZOthersSpeachCell.self)
        tw.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: YZPage_Screen_Width, height: 20))
        view.addSubview(tw)
        return tw
    }()
  
    private  lazy var bottomInputView: YZChatBottomTextView = {
        let bottomView = YZChatBottomTextView()
        view.addSubview(bottomView)
        return bottomView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        socketIOManager.connectSocket()
        
        // MARK: - 键盘即将弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewScrollToBottom()
    }
    
    private func tableViewScrollToBottom(_ isNeedAnimated: Bool = true) {
        
        if (chatRoomTableView.contentSize.height > (YZPage_Screen_Height - YZPage_StatusBar_Height - bottomBtnHeightWithSaveAreaHeight)) {
            
            var offsetY = chatRoomTableView.contentSize.height - chatRoomTableView.bounds.size.height
            
            if offsetY < 0 {
                
                offsetY = 0
            }
            
            if isNeedAnimated {
                
                chatRoomTableView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
                
            } else {
                
                UIView.performWithoutAnimation {
                    
                    chatRoomTableView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
                }
            }
            
        }
    }
    
    override func configUI() {
        
        super.configUI()
        
        bottomInputView.snp_makeConstraints { make in
            
            make.bottom.equalTo(self.view).offset(-YZPage_Safe_Area_Bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(YZCustomDefaultBottomView)
        }
        
        chatRoomTableView.snp_makeConstraints { make in
            
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(bottomInputView.snp_top)
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
        view.endEditing(true)
        
        socketIOManager.autoDisconnectAction()
    }
}

extension YZChatMessageRoomVC:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return messageArrays.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageInfo = messageArrays[indexPath.section]
        
        if let userId = socketIOManager.preChatInfo?.receivedCurrentUserId ,messageInfo.userId == userId {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: YZMySpeachCell.self)
            cell.messageInfo = messageInfo
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: YZOthersSpeachCell.self)
            cell.messageInfo = messageInfo
            return cell
        }
    }
}



//通知
extension YZChatMessageRoomVC {
    
    @objc private func keyboardWillShow(notification: NSNotification) {
     
        tableViewScrollToBottom(false)
    }
}

extension YZChatMessageRoomVC {
    
    private func refreshTableViewAction() {
  
        self.chatRoomTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            self.tableViewScrollToBottom()
            
        }        
    }
}
