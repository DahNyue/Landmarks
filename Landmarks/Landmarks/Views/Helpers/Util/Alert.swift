//
//  Alert.swift
//  PaperPocket
//
//  Created by ChulHyun Jun on 2022/06/15.
//

import Foundation
import UIKit

struct Alert {
    //1개버튼 타입 Alert
    static func showOneButtonAlertController(title : String, subTitle: String? = nil, buttonTitle: String = "확인", okActionHandler : (() -> (Void))? = nil) {
        DispatchQueue.main.async {
            if let alertController = UIStoryboard(name: "AlertPopupViewController", bundle: nil).instantiateViewController(withIdentifier: "AlertPopupViewController") as? AlertPopupViewController {
                alertController.rightButtonCompletion = okActionHandler
                alertController.titleStr = title
                alertController.subTitleStr = subTitle
                alertController.rightButtonTitle = buttonTitle
                alertController.modalPresentationStyle = .overFullScreen
                alertController.modalTransitionStyle = .crossDissolve
                var topController = UIApplication.shared.keyWindow?.rootViewController
                
                while ((topController?.presentedViewController) != nil) {
                    if "\(type(of: topController!.presentedViewController!))" == "SFAuthenticationViewController" {
                        break
                    }
                    topController = topController?.presentedViewController
                }
                topController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    //2개버튼 타입 Alert
    static func showTwoButtonAlertController(title : String, subTitle: String? = nil, cancelTitle : String = "아니요", okTitle : String = "네", cancelHandler : (() -> (Void))? = nil,  okActionHandler : (() -> (Void))?) {
        DispatchQueue.main.async {
            if let alertController = UIStoryboard(name: "AlertPopupViewController", bundle: nil).instantiateViewController(withIdentifier: "AlertPopupViewController") as? AlertPopupViewController {
                alertController.leftButtonCompletion = cancelHandler
                alertController.rightButtonCompletion = okActionHandler
                alertController.titleStr = title
                alertController.subTitleStr = subTitle
                alertController.leftButtonTitle = cancelTitle
                alertController.rightButtonTitle = okTitle
                alertController.isTwoButtonType = true
                alertController.modalPresentationStyle = .overFullScreen
                alertController.modalTransitionStyle = .crossDissolve
                var topController = UIApplication.shared.keyWindow?.rootViewController
                
                while ((topController?.presentedViewController) != nil) {
                    topController = topController?.presentedViewController
                }
                topController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
