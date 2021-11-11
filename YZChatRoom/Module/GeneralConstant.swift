//
//  GeneralConstant.swift
//  YZChatRoom
//
//  Created by YZ-LXH on 2021/3/24.
//

import UIKit
// 屏幕宽度
let YZPage_Screen_Width = UIScreen.main.bounds.size.width

// 屏幕高度
let YZPage_Screen_Height = UIScreen.main.bounds.size.height

let YZPage_IS_IPhoneX: Bool = (
    (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 375, height:812), UIScreen.main.bounds.size) : false) ||
        (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 812, height:375), UIScreen.main.bounds.size) : false) ||
        (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 414, height:896), UIScreen.main.bounds.size) : false) ||
        (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 896, height:414), UIScreen.main.bounds.size) : false))

let YZPage_IS_Iphone: Bool = UIDevice.current.userInterfaceIdiom == .phone

// 导航栏+状态栏高度
let YZPage_NavBar_Height: CGFloat = YZPage_IS_IPhoneX ? 88 : (YZPage_IS_Iphone ? 64 : 74)

let YZPage_StatusBar_Height: CGFloat  = (YZPage_IS_IPhoneX ? 44 : 20)

//底部安全距离
let YZPage_Safe_Area_Bottom: CGFloat = YZPage_IS_IPhoneX ? 34 : 0

let YZCustomDefaultBottomView: CGFloat = 50

//按钮高度+底部安全距离高度总和
let bottomBtnHeightWithSaveAreaHeight = YZPage_Safe_Area_Bottom + YZCustomDefaultBottomView

let baseConnectionLinkage = "baseConnectionLinkage"

/*方法使用*/
//对应屏幕相对宽度
func getScreenWidthRatio(width: CGFloat) -> CGFloat {
    
    return width * YZPage_Screen_Width / 375.0
}

/*
 对应屏幕相对高度
 */
func getScreenHeightRatio(height: CGFloat) -> CGFloat {
    
    return height * YZPage_Screen_Height / 667.0
}

/*
   本地图片
 */
func getImage(_ imageName: String) -> UIImage? {
    
   return UIImage(named: imageName)//图片加载中
}

/*
  字体
 */
func getRegularFontSize(fontSize size: CGFloat, fontWeight weight: UIFont.Weight = UIFont.Weight.regular) -> UIFont {
    
    return UIFont.systemFont(ofSize: size, weight: weight)
}

//斜体
func getitalicSystemFontSize(fontSize size: CGFloat) -> UIFont {
    
    return UIFont.italicSystemFont(ofSize: size)
}

