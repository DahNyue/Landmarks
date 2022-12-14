//
//  View+Extension.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import Foundation
import UIKit
import SwiftUI

/// View의 엣지에 보더를 넣기 위한 구조체
struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    
    // This function changes our View to UIView, then calls another function
    // to convert the newly-made UIView to a UIImage.
    /// View to UIImage
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        // UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        // ㄴ 15.0 deprecated >
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        // here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
    
    /// View에 원하는 엣지에 컬러 보더를 넣는 Extension
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

extension UIView {
    
    // This is the function to convert UIView to UIImage
    /// UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    /// set spring animation
    func spring(_ duration: Double = 0.1125) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut) {
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            } completion: { _ in
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
                    self.transform = CGAffineTransform(scaleX: 0.825, y: 0.825)
                } completion: { _ in
                    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut) {
                        self.transform = CGAffineTransform(scaleX: 1.0125, y: 1.0125)
                    } completion: { _ in
                        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut) {
                            self.transform = CGAffineTransform.identity
                        }
                    }
                }
            }
        }
    }
}
