//
//  PageViewController.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/10.
//

import SwiftUI
import UIKit

/// 코디네이터 패턴이 사용됨
struct PageViewController<Page: View>: UIViewControllerRepresentable { /// UIViewControllerRepresentable 코디네이터를 쓰기 위해 상속하는 SwiftUI계의 델리게이트 프로토콜 같은 것.. View는 UIViewRepresentable을 사용하는 것 같음
    var pages: [Page]
    @Binding var currentPage: Int {
        didSet {
            extractCurrentPage?(currentPage)
        }
    }
    /// currentPage가 변경될 때 콜백으로 전달하기 위해 사용된 extractCurrentPage
    /// LandmarkDetail의 CircleImage 대신하여 사용함
    var extractCurrentPage: ((Int) -> Void)?
    
    /// ~Representable에 속해 필수로 구현해야하는 함수
    /// 사용에 따라 호출되어 코디네이터를 반환해줌 : 델리게이트 패턴의 weak var delegate 역할, 구조체라 이렇게 사용되는 듯함
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// ~Representable에 속해 필수로 구현해야하는 함수
    /// 생성 시 호출되어 내가 정한 컨텍스트 타입을 리턴해줘야 함
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        if pages.count > 1 {
            pageViewController.dataSource = context.coordinator
            pageViewController.delegate = context.coordinator
        } else {
            pageViewController.dataSource = nil
            pageViewController.delegate = nil
        }

        return pageViewController
    }
    
    /// ~Representable에 속해 필수로 구현해야하는 함수
    /// context가 변경될 시 호출됨
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if let viewControllers = context.coordinator.controllers[safe:currentPage] {
            DispatchQueue.main.async {
                /// 페이지 컨트롤러를 셋 해줌
                pageViewController.setViewControllers([viewControllers], direction: .forward, animated: true)
            }
        }
    }
    
    /// 결국 클래스를 사용, 기존 컨트롤러 클래스들의 델리게이트들을 내보낼 시 주로 사용된다.
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        /// 페이지 컨트롤러 상위의 모든 뷰들
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        /// 페이지뷰컨트롤러 데이터소스의 구현 함수 - 이전 페이지의 데이터를 리턴해줌
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController? {
                guard let index = controllers.firstIndex(of: viewController) else {
                    return nil
                }
                if index == 0 {
                    return controllers.last
                }
                return controllers[index - 1]
            }
        
        /// 페이지뷰컨트롤러 데이터소스의 구현 함수 - 다음 페이지의 데이터를 리턴해줌
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController? {
                guard let index = controllers.firstIndex(of: viewController) else {
                    return nil
                }
                if index + 1 == controllers.count {
                    return controllers.first
                }
                return controllers[index + 1]
            }
        
        /// 페이지뷰컨트롤러 델리게이트의 구현 함수 - 페이징 종료 시 페이지를 리턴하는데 사용
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
                if completed,
                   let visibleViewController = pageViewController.viewControllers?.first,
                   let index = controllers.firstIndex(of: visibleViewController) {
                    parent.currentPage = index
                }
            }
    }
}
