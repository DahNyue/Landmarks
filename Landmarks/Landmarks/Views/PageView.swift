//
//  PageView.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/10.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var returnCurrentPage: ((Int) -> Void)?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if pages.count > 0 {
                /// pages에 들어있는 View들을 pages로 갖고 현재 페이지에 대한 정보를 갖고 있고 변경할 수 있는 currentPage를 currentPage로 갖는 페이지 컨트롤러
                /// UIPageVIewController를 사용
                PageViewController(pages: pages, currentPage: $currentPage) { page in
                    returnCurrentPage?(page)
                }
                /// 페이지뷰컨트롤러 하단에 붙어 인디케이터 해주는 PageControl
                /// UIPageControl를 사용
                PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                    .frame(width: CGFloat(pages.count * 18))
                    .padding(.trailing)
            }
        }
    }
}


struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
            .aspectRatio(contentMode: .fit)
    }
}
