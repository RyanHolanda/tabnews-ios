import SwiftUI

private struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        content()
    }
}

struct LazyNavigationLink<Destination: View, Label: View>: View {
    var destination: () -> Destination
    var label: () -> Label

    var body: some View {
        NavigationLink {
            LazyView {
                destination()
            }
        } label: {
            label()
        }
    }
}

#Preview {
    LazyNavigationLink {
        Text("Destination")
    } label: {
        Text("Label")
    }
}
