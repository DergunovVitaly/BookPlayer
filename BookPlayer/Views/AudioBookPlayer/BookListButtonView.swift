//
//  BookListButtonView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

fileprivate struct Constants {
    static let listImageName = "list.bullet"
}

struct BookListButtonView: View {
    @Binding var showBookList: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                self.showBookList.toggle()
            }) {
                Image(systemName: Constants.listImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .padding(15)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    BookListButtonView(showBookList: .constant(false))
}
