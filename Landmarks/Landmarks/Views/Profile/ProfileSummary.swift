//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import SwiftUI

struct ProfileSummary: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var profile: Profile
    
    /*
    var badges: [HikeBadge] = [
        HikeBadge(name: "First Hike", isHover: false),
        HikeBadge(name: "Earth Day", hueRotation: Angle(degrees: 90), isHover: false),
        HikeBadge(name: "Tenth Hike", grayscale: 0.6, hueRotation: Angle(degrees: 45), isHover: false),
        HikeBadge(name: "Fiftieth Hike", grayscale: 0.5, hueRotation: Angle(degrees: 90), isHover: false),
        HikeBadge(name: "Hundredth Hike", grayscale: 0.4, hueRotation: Angle(degrees: 135), isHover: false)
    ]
     */
    @ObservedObject var obsect = HikeBadgeDelegate([
        HikeBadge(name: "First Hike", isHover: false),
        HikeBadge(name: "Earth Day", hueRotation: Angle(degrees: 90), isHover: false),
        HikeBadge(name: "Tenth Hike", grayscale: 0.6, hueRotation: Angle(degrees: 45), isHover: false),
        HikeBadge(name: "Fiftieth Hike", grayscale: 0.5, hueRotation: Angle(degrees: 90), isHover: false),
        HikeBadge(name: "Hundredth Hike", grayscale: 0.4, hueRotation: Angle(degrees: 135), isHover: false)
    ])
    
    /*
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd sss"
        return formatter
    }()
    
    let dateFormatStyle: Date.FormatStyle = {
        Date.FormatStyle()
            .second(.twoDigits)
            .locale(Locale(identifier: "ko_KR"))
    }()
    */
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)

                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date) // Text(profile.goalDate, formatter: self.dateFormat)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(self.obsect.badges, id: \.name) { badge in
                                badge
                            }
                            /*
                            HikeBadge(name: "First Hike") { (name, isSelected) in
                                self.obsect.toggle(id: name, isSelected: isSelected)
                            }
                            
                            HikeBadge(name: "Earth Day", hueRotation: Angle(degrees: 90)) { (name, isSelected) in
                                self.obsect.toggle(id: name, isSelected: isSelected)
                            }
                            /*
                                .hueRotation(Angle(degrees: 90))
                             */
                            
                            HikeBadge(name: "Tenth Hike", grayscale: 0.6, hueRotation: Angle(degrees: 45)) { (name, isSelected) in
                                self.obsect.toggle(id: name, isSelected: isSelected)
                            }
                            /*
                                .grayscale(0.6)
                                .hueRotation(Angle(degrees: 45))
                             */
                            
                            HikeBadge(name: "Fiftieth Hike", grayscale: 0.5, hueRotation: Angle(degrees: 90)) { (name, isSelected) in
                                self.obsect.toggle(id: name, isSelected: isSelected)
                            }
                            /*
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 90))
                             */
                            
                            HikeBadge(name: "Hundredth Hike", grayscale: 0.4, hueRotation: Angle(degrees: 135)) { (name, isSelected) in
                                self.obsect.toggle(id: name, isSelected: isSelected)
                            }
                            /*
                                .grayscale(0.4)
                                .hueRotation(Angle(degrees: 135))
                             */
                             */
                        }
                        .padding(.vertical)
                    }
                }
                
                Divider()

                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)

                    HikeView(hike: modelData.hikes[0])
                }
            }
        }
    }
}

class HikeBadgeDelegate : ObservableObject {
    @Published var badges: [HikeBadge] = []
    
    convenience init(_ initBadges: [HikeBadge]) {
        self.init()
        self.badges = initBadges
    }
    
    func toggle(id: String, isSelected: Bool) {
        if isSelected == true {
            badges.indices.filter{badges[$0].name != id}.forEach{
                badges[$0].isHover = false
                print(":: not \(badges[$0].name), \(badges[$0].isHover)")
            }
            badges.indices.filter{badges[$0].name == id}.forEach{
                badges[$0].isHover = isSelected
                print(":: \(isSelected) \(badges[$0].name), \(badges[$0].isHover)")
            }
        }
//        if let willChangeBadge = self.badges.first(where: { $0.name.contains(id) }) {
//            willChangeBadge.isHover.toggle()
//        }
        print(":: \(badges.map{ $0.name }), \(badges.map{ $0.isHover })")
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
            .environmentObject(ModelData())
    }
}
