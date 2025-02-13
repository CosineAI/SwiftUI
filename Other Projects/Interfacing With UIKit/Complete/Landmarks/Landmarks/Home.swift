/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of all of the landmarks.
*/

import SwiftUI

struct CategoryHome: View {
    @State private var isProfilePresented = false

    var categories: [String: [Landmark]] {
        .init(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var featured: [Landmark] {
        landmarkData.filter { $0.isFeatured }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    FeaturedLandmarks(landmarks: featured)
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                    
                    ForEach(categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: self.categories[key]!)
                    }
                    .frame(height: 185)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.top)
                
                NavigationLink(destination: LandmarkList()) {
                    Text("See All")
                        .font(.headline)
                }
                .padding(.leading)
            }
            .navigationBarTitle(Text("Featured"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isProfilePresented = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .accessibility(label: Text("User Profile"))
                            .imageScale(.large)
                            .padding()
                    }
                    .sheet(isPresented: $isProfilePresented,
                            content: { ProfileHost().environmentObject(UserData()) })
                }
            }
        }
    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View {
        landmarks[0].image
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#if DEBUG
struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
#endif