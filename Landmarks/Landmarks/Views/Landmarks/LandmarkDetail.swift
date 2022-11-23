//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/03.
//

import SwiftUI

struct LandmarkDetail: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var landmark: Landmark
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id }) ?? 0
    }
    
    @Environment(\.dismiss) private var dismiss
    
    let offsetID = "CONSTANT_CONTENTSOFFSET"

    var body: some View {
//        ScrollView(offsetChanged: { offset in
//            print("offset : \(offset)")
//            self.offset = offset
//        }) {
        ScrollView {
            ScrollViewReader { proxy in /// 스크롤 뷰의 컨텐츠를 리턴하는 느낌으로 이해, 스크롤뷰 안에 사용
                VStack {
                    MapView(name: landmark.name, coordinate: landmark.locationCoordinate)
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 380)
                    
                    CircleImage(preferredViewType: modelData.profile.preferredViewType, imageNames: landmark.imageNames)
                        .offset(y: -130)
                        .padding(.bottom, -130)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(landmark.name)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(landmark.color)
                                .multilineTextAlignment(.center)
                            FavoriteButton(id: landmark.id, isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                        }
                        HStack {
                            Text(landmark.address)
                                .font(.subheadline)
                            Spacer()
                            Text(landmark.state)
                                .font(.subheadline)
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        
                        Divider()
                        
                        Text("About \(landmark.name)")
                            .font(.title2)
                        Text(landmark.description)
                    }
                    .padding()
                    
                    Spacer()
                }
                .navigationTitle(landmark.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .navigationBarItems(
                    leading:
                        Image(systemName: "chevron.backward")
                        .onTapGesture {
                            dismiss()
                        },
                    trailing:
                        FavoriteButton(id: landmark.id, isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                )
                .padding(.bottom, 500)
                .overlay {
                    GeometryReader { superView in
                        Color.clear
                            .frame(width: 200, height: UIScreen.main.bounds.size.height + 65)
                            .id(offsetID)
                    }
                }
                .onAppear {
                    proxy.scrollTo(offsetID)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks.last!)
    }
}
/*
// MARK: ScrollView for get offset
struct ScrollView<Content: View>: View {
    
    let axes: Axis.Set
    let showsIndicators: Bool
    let offsetChanged: (CGPoint) -> Void
    let content: Content

    init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        SwiftUI.ScrollView(axes, showsIndicators: showsIndicators) {
            GeometryReader { geometry in
                Color.clear.preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geometry.frame(in: .named("scrollView")).origin
                )
            }.frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
*/
/*
// MARK: ScrollableView for set offset
struct ScrollableView<Content: View>: UIViewControllerRepresentable, Equatable {

    // MARK: - Coordinator
    final class Coordinator: NSObject, UIScrollViewDelegate {
        
        // MARK: - Properties
        private let scrollView: UIScrollView
        var offset: Binding<CGPoint>

        // MARK: - Init
        init(_ scrollView: UIScrollView, offset: Binding<CGPoint>) {
            self.scrollView          = scrollView
            self.offset              = offset
            super.init()
            self.scrollView.delegate = self
        }
        
        // MARK: - UIScrollViewDelegate
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.offset.wrappedValue = scrollView.contentOffset
            }
        }
    }
    
    // MARK: - Type
    typealias UIViewControllerType = UIScrollViewController<Content>
    
    // MARK: - Properties
    var offset: Binding<CGPoint>
    var animationDuration: TimeInterval
    var showsScrollIndicator: Bool
    var axis: Axis
    var content: () -> Content
    var onScale: ((CGFloat)->Void)?
    var disableScroll: Bool
    var forceRefresh: Bool
    var stopScrolling: Binding<Bool>
    private let scrollViewController: UIViewControllerType

    // MARK: - Init
    init(_ offset: Binding<CGPoint>, animationDuration: TimeInterval, showsScrollIndicator: Bool = true, axis: Axis = .vertical, onScale: ((CGFloat)->Void)? = nil, disableScroll: Bool = false, forceRefresh: Bool = false, stopScrolling: Binding<Bool> = .constant(false),  @ViewBuilder content: @escaping () -> Content) {
        self.offset               = offset
        self.onScale              = onScale
        self.animationDuration    = animationDuration
        self.content              = content
        self.showsScrollIndicator = showsScrollIndicator
        self.axis                 = axis
        self.disableScroll        = disableScroll
        self.forceRefresh         = forceRefresh
        self.stopScrolling        = stopScrolling
        self.scrollViewController = UIScrollViewController(rootView: self.content(), offset: self.offset, axis: self.axis, onScale: self.onScale)
    }
    
    // MARK: - Updates
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewControllerType {
        self.scrollViewController
    }

    func updateUIViewController(_ viewController: UIViewControllerType, context: UIViewControllerRepresentableContext<Self>) {
        
        viewController.scrollView.showsVerticalScrollIndicator   = self.showsScrollIndicator
        viewController.scrollView.showsHorizontalScrollIndicator = self.showsScrollIndicator
        viewController.updateContent(self.content)

        let duration: TimeInterval                = self.duration(viewController)
        let newValue: CGPoint                     = self.offset.wrappedValue
        viewController.scrollView.isScrollEnabled = !self.disableScroll
        
        if self.stopScrolling.wrappedValue {
            viewController.scrollView.setContentOffset(viewController.scrollView.contentOffset, animated:false)
            return
        }
        
        guard duration != .zero else {
            viewController.scrollView.contentOffset = newValue
            return
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .curveEaseInOut, .beginFromCurrentState], animations: {
            viewController.scrollView.contentOffset = newValue
        }, completion: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self.scrollViewController.scrollView, offset: self.offset)
    }
    
    //Calcaulte max offset
    private func newContentOffset(_ viewController: UIViewControllerType, newValue: CGPoint) -> CGPoint {
        
        let maxOffsetViewFrame: CGRect = viewController.view.frame
        let maxOffsetFrame: CGRect     = viewController.hostingController.view.frame
        let maxOffsetX: CGFloat        = maxOffsetFrame.maxX - maxOffsetViewFrame.maxX
        let maxOffsetY: CGFloat        = maxOffsetFrame.maxY - maxOffsetViewFrame.maxY
        
        return CGPoint(x: min(newValue.x, maxOffsetX), y: min(newValue.y, maxOffsetY))
    }
    
    //Calculate animation speed
    private func duration(_ viewController: UIViewControllerType) -> TimeInterval {
        
        var diff: CGFloat = 0
        
        switch axis {
            case .horizontal:
                diff = abs(viewController.scrollView.contentOffset.x - self.offset.wrappedValue.x)
            default:
                diff = abs(viewController.scrollView.contentOffset.y - self.offset.wrappedValue.y)
        }
        
        if diff == 0 {
            return .zero
        }
        
        let percentageMoved = diff / UIScreen.main.bounds.height
        
        return self.animationDuration * min(max(TimeInterval(percentageMoved), 0.25), 1)
    }
    
    // MARK: - Equatable
    static func == (lhs: ScrollableView, rhs: ScrollableView) -> Bool {
        return !lhs.forceRefresh && lhs.forceRefresh == rhs.forceRefresh
    }
}

final class UIScrollViewController<Content: View> : UIViewController, ObservableObject {

    // MARK: - Properties
    var offset: Binding<CGPoint>
    var onScale: ((CGFloat)->Void)?
    let hostingController: UIHostingController<Content>
    private let axis: Axis
    lazy var scrollView: UIScrollView = {
        
        let scrollView                                       = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.canCancelContentTouches                   = true
        scrollView.delaysContentTouches                      = true
        scrollView.scrollsToTop                              = false
        scrollView.backgroundColor                           = .clear
        
        if self.onScale != nil {
            scrollView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(self.onGesture)))
        }
        
        return scrollView
    }()
    
    @objc func onGesture(gesture: UIPinchGestureRecognizer) {
        self.onScale?(gesture.scale)
    }

    // MARK: - Init
    init(rootView: Content, offset: Binding<CGPoint>, axis: Axis, onScale: ((CGFloat)->Void)?) {
        self.offset                                 = offset
        self.hostingController                      = UIHostingController<Content>(rootView: rootView)
        self.hostingController.view.backgroundColor = .clear
        self.axis                                   = axis
        self.onScale                                = onScale
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Update
    func updateContent(_ content: () -> Content) {
        
        self.hostingController.rootView = content()
        self.scrollView.addSubview(self.hostingController.view)
        
        var contentSize: CGSize = self.hostingController.view.intrinsicContentSize
        
        switch axis {
            case .vertical:
                contentSize.width = self.scrollView.frame.width
            case .horizontal:
                contentSize.height = self.scrollView.frame.height
        }
        
        self.hostingController.view.frame.size = contentSize
        self.scrollView.contentSize            = contentSize
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.createConstraints()
        self.view.setNeedsUpdateConstraints()
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Constraints
    fileprivate func createConstraints() {
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
*/
