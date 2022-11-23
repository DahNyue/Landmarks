//
//  Navigation+Extension.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/16.
//

import Foundation
import UIKit

extension UINavigationController : UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    /// Navigation Stack에 쌓인 뷰가 1개를 초과해야 제스처가 동작 하도록
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return viewControllers.count > 1
    }

}
