//
//  UserItemView.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation
import SwiftUI

struct UserItemView: View {
    let user: User

    var body: some View {
        VStack {
            AsyncImage(url: user.profilePictureURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            } placeholder: {
                Image(systemName: "person.fill")
            }
            Text(user.name)
                .font(.caption)
                .lineLimit(1)
        }
        .frame(width: 80)
    }
}
