import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.down")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.secondary)
                .padding(.vertical, 8.5)
                .padding(.horizontal, 5)
                .background(.secondary.opacity(0.2))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
        }.buttonStyle(.plain)
    }
}

#Preview {
    DismissButton()
}
