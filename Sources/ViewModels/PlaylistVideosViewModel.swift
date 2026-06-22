import Foundation
import Observation

@MainActor
@Observable
final class PlaylistVideosViewModel {
    let playlist: Playlist
    private(set) var videos: [Video] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private var isLoaded = false
    
    init(playlist: Playlist) {
        self.playlist = playlist
    }
    
    func loadIfNeeded() {
        guard !isLoaded else { return }
        isLoaded = true
        Task { await reload() }
    }
    
    func reload() async {
        isLoading = true
        errorMessage = nil
        do {
            videos = try await AppClient.make().playlistVideos(playlistId: playlist.id)
        } catch APIError.empty {
            videos = []
            errorMessage = "This playlist has no videos."
        } catch {
            videos = []
            errorMessage = (error as? APIError)?.errorDescription ?? "Couldn't load playlist videos."
        }
        isLoading = false
    }
}
