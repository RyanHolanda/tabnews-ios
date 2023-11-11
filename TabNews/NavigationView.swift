import SwiftUI

struct NavigationView: View {
    var body: some View {
        TabView {
            RecentsView.create()
                .tabItem { Label(
                    title: { Text("Recentes") },
                    icon: { Image(systemName: "clock")
                    }
                ) }

            RelevantsView.create()
                .tabItem { Label(
                    title: { Text("Relevantes") },
                    icon: { Image(systemName: "lightbulb") }
                ) }
        }
    }
}

#Preview {
    NavigationView()
}
