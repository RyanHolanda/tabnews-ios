import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            RecentsView.create()
                .tabItem { Label(
                    title: { Text(.localizable.recents) },
                    icon: { Image(systemName: "clock")
                    }
                ) }

            RelevantsView.create()
                .tabItem { Label(
                    title: { Text(.localizable.relevants) },
                    icon: { Image(systemName: "lightbulb") }
                ) }
        }
    }
}

#Preview {
    MainView()
}
