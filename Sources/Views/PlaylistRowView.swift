import SwiftUI

struct PlaylistRowView: View {
    let playlist: Playlist

    var body: some View {
        HStack(spacing: 8) {
            if let url = playlist.thumbnailURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 48, height: 36)
                .cornerRadius(4)
                .clipped()
            } else {
                Image(systemName: "music.note.list")
                    .frame(width: 48, height: 36)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(playlist.title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                if let count = playlist.videoCountText {
                    Text(count)
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 2)
    }
}
