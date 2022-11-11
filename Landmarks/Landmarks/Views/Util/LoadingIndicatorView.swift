//
//  LoadingIndicatorView.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/11.
//

import Foundation
import UIKit
import SnapKit

class LoadingIndicatorView: UIView {
    
    /** @brief Xib로 그려진 containerView */
    @IBOutlet var containerView: UIView!
    
    /** @brief loadingIndicator*/
    @IBOutlet var ivIndicator: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("LoadingIndicatorView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //인디케이터 이미지 로테이션 애니메이션 시작
    func loadingRotateAnimation() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        ivIndicator.layer.add(rotation, forKey: "rotationAnimation")
    }
}
