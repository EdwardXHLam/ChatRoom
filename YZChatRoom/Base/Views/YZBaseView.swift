//
//  YZBaseView.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/24.
//

import UIKit

class YZBaseView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}

}
