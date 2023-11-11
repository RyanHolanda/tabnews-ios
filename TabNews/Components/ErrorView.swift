import SwiftUI

struct ErrorView: View {
    var title: String?
    var description: String?
    let onTryAgain: () -> Void

    var body: some View {
        Image(systemName: "exclamationmark.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .foregroundStyle(.red)

        Text(title ?? String(localized: .localizable.errorViewTitle))
            .font(.title3)
            .fontWeight(.bold)
            .padding(.top, 20)

        Text(description ?? String(localized: .localizable.errorViewDescription))
            .font(.subheadline)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)

        Button(String(localized: .localizable.tryAgain.localizedStringResource)) {
            onTryAgain()
        }
        .padding(.top, 10)
    }
}

#Preview {
    ErrorView(title: "Error", description: "Something went wrong. Please try again") {}
}
