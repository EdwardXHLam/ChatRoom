//
//  YZModelInfo.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/25.
//

import HandyJSON

struct messageModel: HandyJSON {

     var msg: String?
     var msgType: String?
     var phoneModel: String?
     var roomId: String?
     var userId: String?
}


struct chatRequiredInfo: HandyJSON {

     var deliveredRoomId: String?
     var isPrivateChat = true
     var receivedCurrentUserId: String?
     var receivedOtherUserId: String?
}

