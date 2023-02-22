//
//  CharacterView.swift
//  BB Quotes
//
//  Created by Oscar David Myerston Vega on 17/03/23.
//

import SwiftUI

struct CharacterView: View {
    let show: String
    let character: Character

    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Image(show.filter { $0 != " "})
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                VStack {
                    AsyncImage(url: character.image) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(25)
                            .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/2)
                            .padding(.top, 50)

                    } placeholder: {
                        ProgressView()
                    }

                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        Text("\(character.name) Character Info")
                            .font(.title2)
                            .padding(.top, 7)

                        Text("Born: \(character.birthday)")
                        Text("Occupations: \(character.occupation.joined(separator: ","))")
                        Text("Nickname: \(character.nickname)")
                    }
                    .padding()
                }
            }
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(show: "Better Call Saul", character: try! JSONDecoder().decode(Character.self, from: Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)) )
    }
}
