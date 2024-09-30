//
//  YZSocketIOManager.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/18.
//

import UIKit
import SocketIO

fileprivate let privateChatType = "privateEvent"

fileprivate let groupChatType = "groupEvent"

fileprivate let defaultAppID = "defaultAppID"

class YZSocketIOManager: NSObject {
    
    static let shared = YZSocketIOManager()

    private var socketIO: SocketIOClient?
    
    private var socketManager: SocketManager?
    
    var isConnected : Bool = false
    
    private var reConnectCount: Int = 0
    
    var callBackInfo: (([Any], SocketAckEmitter?) -> ())?
    
    var statusCallBackInfo: ((SocketIOStatus) -> ())?
    
    private var _chatInfo:chatRequiredInfo?
    
    var preChatInfo:chatRequiredInfo? {
        
        get{
            return _chatInfo
        }
        
        set{
            _chatInfo = newValue
        }
    }
    
    override init() {
     
    }
    //MARK: 基础配置
    open func basicSettings(roomId: String?, currentUserId: String?, otherUserId: String?, isPrivate: Bool) {
        
        preChatInfo = chatRequiredInfo()
        
        _chatInfo?.deliveredRoomId = roomId

        _chatInfo?.receivedCurrentUserId = currentUserId

        _chatInfo?.receivedOtherUserId = otherUserId

        _chatInfo?.isPrivateChat = isPrivate
    }
}

//MARK: 连接/断开连接/发送消息
extension YZSocketIOManager {
    
    //MARK: 连接
    open func connectSocket(_ header: Any? = nil, _ parameters: Any? = nil) {

        var actualParameters = [String : Any]()
        
        let timeStamp = Date().milliStamp
        
        actualParameters["timeStamp"] = timeStamp
        
        if let chatInfo = _chatInfo {
    
            if !chatInfo.isPrivateChat, let actualRoomId = chatInfo.deliveredRoomId {
                
                actualParameters["roomId"] = actualRoomId
            }
            
            actualParameters["sign"] = applySign().md5
            
            var baseHeaderInfo = [String : Any]()
            
            baseHeaderInfo["appType"] = "4"
            
            if let currentUserId = chatInfo.receivedCurrentUserId {
                
                baseHeaderInfo["userId"] = currentUserId
                
            }
            
            baseHeaderInfo["imCode"] = chatInfo.isPrivateChat ? "PRCODE" : "GRCODE"
            
            baseHeaderInfo["appId"] = defaultAppID
            
            if let capturedHeader = header as? [String : Any] {
                
                baseHeaderInfo =  baseHeaderInfo.union(capturedHeader)
            }
            
            let requestDict = ["header" : baseHeaderInfo, "body": actualParameters]
            
            guard let url = URL(string: baseConnectionLinkage), let requestJson = requestDict.formatJSON() else { return }
            
            let SSLSecu = SSLSecurity.init(usePublicKeys: true)
            
            socketManager = SocketManager(socketURL: url, config: ["log": true, "forceWebsockets":true,"forcePolling":true,"compress":true,"forceNew":true,"reconnectAttempts":5,"selfSigned":true,"security":SSLSecu,"connectParams":["reqStr":requestJson]])
            
            socketIO = socketManager?.defaultSocket
            
            socketIO?.on("connect", callback: { [weak self] data, ack in
                
                if self?.socketIO?.status == SocketIOStatus.connected {
                    
                    self?.proceedCurrentSocketStatus()
                    
                    print("接收到了:",data.description)
                }
            })
            
            socketIO?.on(clientEvent: .error) { [weak self] data,ack in
                
                if self?.socketIO?.status == SocketIOStatus.notConnected {
                    
                    self?.socketIO?.connect()
                }
                
                print("错误了---：",data.debugDescription)
            }
            
            socketIO?.connect()
            
            proceedCurrentSocketStatus()
            
            socketIO?.on(clientEvent: .disconnect, callback: { [weak self] data, ack in
                
                self?.proceedCurrentSocketStatus()
                
                print("断开链接了---：",data.debugDescription)
            })
            
            socketIO?.on(privateChatType, callback: { [weak self] data, ack in
                self?.proceedDatas(data: data, ack: ack)
                print("接收到私聊---",data)
            })
            
            socketIO?.on(groupChatType, callback: { [weak self] data, ack in
                self?.proceedDatas(data: data, ack: ack)
                
                print("接收到群聊---",data)
            })
        }
        
    }
    
    private func proceedCurrentSocketStatus() {
        
        if let statusCall = statusCallBackInfo {
            
            statusCall(socketIO?.status ?? .connecting)
        }
    }
    
    private func proceedDatas(data: [Any], ack: SocketAckEmitter?) {
        
        if let dataArrays = data as? [[String : Any]] {
            
            if let call = callBackInfo {
                
                var messageArrays = [messageModel]()
                
                dataArrays.forEach { subDict in
                    
                    if let object = messageModel.deserialize(from: subDict) {
                        
                        messageArrays.append(object)
                    }
                }
                
                call(messageArrays,ack)
            }
        }
    }

    //MARK: 断开连接
    open func autoDisconnectAction() {
        
        preChatInfo = nil
        
        socketIO?.disconnect()
    }
   
    //MARK: 发送消息
    open func sendPrivateMessages(message: String, _ parameters: Any? = nil) {
        
        var actualParameters = [String : Any]()
        
        actualParameters["phoneModel"] = "iOS"
        
        if let chatInfo = _chatInfo {
            
            actualParameters["msgType"] = chatInfo.isPrivateChat ? "1" : "2"
            
            if let uid = chatInfo.receivedCurrentUserId {
                
                actualParameters["userId"] = uid
            }
            
            if chatInfo.isPrivateChat, let targetId = chatInfo.receivedOtherUserId {
                
                actualParameters["targetId"] = targetId
            }
            
            if !chatInfo.isPrivateChat, let roomId = chatInfo.deliveredRoomId {
                
                actualParameters["roomId"] = roomId
            }
            
            actualParameters["msg"] = message
            
            if let capturedParams = parameters as? [String : Any] {
                
                actualParameters = actualParameters.union(capturedParams)
            }
            
            if chatInfo.isPrivateChat {
                
                proceedDatas(data: [actualParameters], ack: nil)
            }
            
            socketIO?.emit(chatInfo.isPrivateChat ? privateChatType : groupChatType, with: [actualParameters])
            
        }
    }
}

extension YZSocketIOManager {
    
    private func applySign() -> String {

        let timeStamp = Date().milliStamp
        
        var signParameters = [String : Any]()

        signParameters["app_id"] = defaultAppID

        signParameters["app_secret"] = "app_secret____"

        signParameters["merchant_id"] = defaultAppID

        signParameters["time_stamp"] = timeStamp
        
        /*
              iOS字典是无序的， 为了满足后台升序要求，只能做额外处理
          */
        
        let signSortKeys = signParameters.sorted { $0.key < $1.key }
       
        var sign = "{"
        
        for (index, item) in signSortKeys.enumerated() {
            
            sign += "\"\(item.key)\":\"\(item.value)\"\(index == signSortKeys.count - 1 ? "" : ",")"
        }
        
        sign += "}"
        
        return sign
    }
}

//UPDATE IMPACTS


//GEN-TEST
