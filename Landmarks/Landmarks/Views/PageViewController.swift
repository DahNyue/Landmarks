//
//  PageViewController.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/10.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int {
        didSet {
            extractCurrentPage?(currentPage)
        }
    }
    var extractCurrentPage: ((Int) -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

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

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if let viewControllers = context.coordinator.controllers[safe:currentPage] {
            DispatchQueue.main.async {
                pageViewController.setViewControllers([viewControllers], direction: .forward, animated: true)
            }
        }
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
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
