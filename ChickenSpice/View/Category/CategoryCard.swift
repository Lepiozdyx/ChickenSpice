//
//  CategoryCard.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 26.09.2025.
//

import SwiftUI

struct CategoryCard: View {
    let category: Categories
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundColor(.clear)
                .overlay(
                    Image(category.icon)
                        .resizable()
                        .scaledToFill()
                )
                .clipped()
            
            Text(category.title)
                .font(.custom(.MontserratBold, size: 18))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 0, y: 2)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
        }
        .frame(height: UIScreen.main.bounds.height / 4)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
    }
}
