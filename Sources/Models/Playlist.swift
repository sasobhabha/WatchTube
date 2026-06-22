import Foundation

struct Playlist: Identifiable, Hashable, Codable {
    let id: String              // the playlistId, e.g. "PL..."
    let title: String
    let videoCountText: String? // "15 videos" or similar
    let thumbnailURL: URL?
    let channelTitle: String?

    var browseId: String {
        "VL\(id)"
    }
}
