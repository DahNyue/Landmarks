//
//  AlertPopupViewController.swift
//  PaperPocket
//
//  Created by ChulHyun Jun on 2022/06/15.
//

import UIKit

class AlertPopupViewController: UIViewController {
    typealias blockCompletion = () -> (Void)
    
    // 왼쪽 버튼 이벤트 클로져
    var leftButtonCompletion: blockCompletion?
    // 오른쪽 버튼 이벤트 클로져
    var rightButtonCompletion: blockCompletion?
    
    var isTwoButtonType: Bool = false
    // 제목
    var titleStr: String?
    // 부제목
    var subTitleStr: String?
    // 왼쪽 버튼 타이틀
    var leftButtonTitle: String?
    // 오른쪽 버튼 타이틀
    var rightButtonTitle: String?
    
    @IBOutlet weak var vAlertContainer: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    @IBOutlet weak var vLeft: UIView!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var vRight: UIView!
    @IBOutlet weak var btnRight: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 버튼 갯수에 따라 노출
        vLeft.isHidden = !isTwoButtonType
        lbTitle.text = titleStr
        lbSubTitle.text = subTitleStr
        // subtitle이 있을경우에만 노출
        lbSubTitle.isHidden = (subTitleStr == nil)
        btnLeft.setTitle(leftButtonTitle, for: .normal)
        btnRight.setTitle(rightButtonTitle, for: .normal)
    }
    
    // 좌측 '아니요'버튼 이벤트
    @IBAction func cancelButtonTouched(_ sender: Any) {
        self.vAlertContainer.spring()
        dismiss(animated: true) { [weak self] in
            guard let `self` = self else {return}
            self.leftButtonCompletion?()
        }
    }
    
    // 우측 '네'버튼 이벤트
    @IBAction func okButtonTouched(_ sender: Any) {
        self.vAlertContainer.spring()
        dismiss(animated: true) { [weak self] in
            guard let `self` = self else {return}
            self.rightButtonCompletion?()
        }
    }
}
