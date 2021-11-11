//
//  ViewController.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/2/19.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    @IBOutlet weak var currentUserIdTextField: UITextField!
    
    @IBOutlet weak var receivedMessageLabel: UILabel!
    
    @IBOutlet weak var connectToOthersTextField: UITextField!
    
    @IBOutlet weak var deliverMessageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createConnectionAction(_ sender: UIButton) {
        
        if let currentID = currentUserIdTextField.text, !currentID.isBlank {
            
            YZSocketIOManager.shared.connectSocket(roomId: "100", header: ["appId":"yz1222","imCode":"YZPRCODE","userId":currentID], parameters: nil)
        }
    }
    
    @IBAction func sendMessageAction(_ sender: UIButton) {

        if let otherId = connectToOthersTextField.text, !otherId.isBlank, let message = deliverMessageTextView.text, !message.isBlank,let currentID = currentUserIdTextField.text, !currentID.isBlank {
            
            YZSocketIOManager.shared.sendPrivateMessages(parameters: ["targetId":currentID,"uid":otherId,"msg":message])
        }
    }
}


