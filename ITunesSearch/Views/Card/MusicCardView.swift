//
//  MusicCardView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/12.
//

import SwiftUI

struct MusicCardView: View {
    let music: Music
    
    var body: some View {
        HStack(spacing: 20) {
            coverImage
            cardInfo
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .padding()
    }
    
    var coverImage: some View {
        AsyncImage(url: music.artworkUrl100) { phase in
            switch phase {
                case .empty:
                    Color.gray.opacity(0.8)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    loadingErrorIcon
            }
            
        }
        .frame(width: 80, height: 80)
        .background(.gray.opacity(0.3))
        .clipShape(.rect(cornerRadius: 8))
        .scaledToFit()
    }
    
    var loadingErrorIcon: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 25)
            .foregroundStyle(.red)
    }
    
    var cardInfo: some View {
        VStack(alignment: .leading) {
            Text(music.trackName)
                .bold()
                .font(.title3)
                .padding([.bottom], 2)

            Group {
                Text(music.collectionName)
                Text(music.artistName)
            }
            .clipped()
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.gray)
        }
    }
}


#Preview {

    let music = Music(
        artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/64/a0/f1/64a0f1b8-a36b-ff10-509a-9a8f5fef53ff/dj.zfoqlnar.jpg/100x100bb.jpg")!,
        artistViewUrl: URL(string: "https://music.apple.com/us/artist/mayday/369211611?uo=4")!,
        collectionViewUrl: URL(string: "https://music.apple.com/us/album/%E5%BE%8C%E4%BE%86%E7%9A%84%E6%88%91%E5%80%91/1158763922?i=1158763996&uo=4")!,
        previewUrl: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/91/30/64/9130646e-c52a-5b50-b472-a0614c583da2/mzaf_10722775092036331265.plus.aac.p.m4a")!,
        trackId: 1158763996,
        collectionId: 1158763922,
        artistId: 369211611,
        trackName: "後來的我們",
        collectionName: "自傳",
        artistName: "Mayday",
        releaseDate: "2016-07-21T07:00:00Z".prefix(10).replacingOccurrences(of: "-", with: "/")
    )
    
    return MusicCardView(music: music)

}
