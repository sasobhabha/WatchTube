import SwiftUI

struct PlaylistDetailView: View {
    @State private var model: PlaylistVideosViewModel

    init(playlist: Playlist) {
        _model = State(initialValue: PlaylistVideosViewModel(playlist: playlist))
    }

    var body: some View {
        List {
            Section {
                if model.isLoading && model.videos.isEmpty {
                    ForEach(0..<3, id: \.self) { _ in SkeletonRow() }
                } else if let error = model.errorMessage, model.videos.isEmpty {
                    EmptyStateRow(icon: "exclamationmark.icloud", text: error)
                } else {
                    ForEach(model.videos) { video in
                        NavigationLink(value: video) { VideoRowView(video: video) }
                    }
                }
            } header: {
                Label(model.playlist.title, systemImage: "music.note.list")
            }
        }
        .navigationTitle(model.playlist.title)
        .navigationDestination(for: Video.self) { PlayerView(video: $0) }
        .navigationDestination(for: ChannelRef.self) { ChannelView(channel: $0) }
        .brandBackdrop()
        .onAppear { model.loadIfNeeded() }
        .refreshable { await model.reload() }
    }
}
