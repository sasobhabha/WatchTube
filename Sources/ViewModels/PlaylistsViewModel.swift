import Foundation
import Observation

@MainActor
@Observable
final class PlaylistsViewModel {
    private(set) var playlists: [Playlist] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private var isLoaded = false
    
    func loadIfNeeded() {
        guard !isLoaded else { return }
        isLoaded = true
        Task { await reload() }
    }
    
    func reload() async {
        isLoading = true
        errorMessage = nil
        do {
            playlists = try await AppClient.make().accountPlaylists()
        } catch APIError.empty {
            playlists = []
            errorMessage = "No playlists found."
        } catch {
            playlists = []
            errorMessage = (error as? APIError)?.errorDescription ?? "Couldn't load playlists."
        }
        isLoading = false
    }
}
