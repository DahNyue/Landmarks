//
//  LoadingIndicatorManager.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/11.
//

import Foundation
import UIKit
import SnapKit

class LoadingIndicatorManager {
    static let shared = LoadingIndicatorManager()
    var timeCount: Int = 0
    var timer: Timer?
    //현재 인디케이터가 노출중인지 아닌지 체크
    var isShowIndicator: Bool = false
    //로딩인디케이터뷰 객체
    private lazy var loadingIndicatorView = {
        return LoadingIndicatorView.init()
    }()
    
    //인디케이터를 노출처리한다.
    private func showIndicator() {
        //최상위 윈도우의 뷰를 갖고와서 그위에 노출한다.
        guard let topWindow = UIApplication.shared.windows.last else {return}
        topWindow.addSubview(loadingIndicatorView)
        loadingIndicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //인디케이터 로딩 애니메이션 시작
        loadingIndicatorView.loadingRotateAnimation()
        isShowIndicator = true
        
        timer?.invalidate()
        timeCount = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] timer in
            guard let `self` = self else {return}
            self.timeCount += 1 // 1씩 카운트 값 증가 실시
            if self.timeCount > 20 {
                self.hideIndicator()
                timer.invalidate()
            }
        })
        
    }

    //인디케이터를 숨김처리한다.
    private func hideIndicator() {
        isShowIndicator = false
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicatorView.removeFromSuperview()
        }
    }
    
    
    /// 인디케이터를 노출/숨김 처리한다.
    /// - Parameter isShow: true: 노출, false: 숨김
    /// - Parameter backgroundColor: backgroundColor 지정
    func showIndicator(isShow: Bool, backgroundColor: UIColor? = nil) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicatorView.backgroundColor = backgroundColor ?? UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
        
        if isShow {
            showIndicator()
        } else {
            hideIndicator()
        }
    }
}
