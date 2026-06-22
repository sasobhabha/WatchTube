import SwiftUI

struct PlaylistsListView: View {
    @State private var model = PlaylistsViewModel()

    var body: some View {
        List {
            if model.isLoading && model.playlists.isEmpty {
                ForEach(0..<3, id: \.self) { _ in SkeletonRow() }
            } else if let error = model.errorMessage, model.playlists.isEmpty {
                EmptyStateRow(icon: "exclamationmark.icloud", text: error)
            } else {
                ForEach(model.playlists) { playlist in
                    NavigationLink {
                        PlaylistDetailView(playlist: playlist)
                    } label: {
                        PlaylistRowView(playlist: playlist)
                    }
                }
            }
        }
        .navigationTitle("Playlists")
        .brandBackdrop()
        .onAppear { model.loadIfNeeded() }
        .refreshable { await model.reload() }
    }
}
