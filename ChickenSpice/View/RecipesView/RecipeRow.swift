//
//  RecipeRow.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 26.09.2025.
//
import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    @EnvironmentObject private var favoriteManager: FavoriteManager
    
    private var isFavorite: Bool {
        favoriteManager.isFavorite(recipeTitle: recipe.title)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 135, height: 135)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.custom(.MontserratBold, size: 14))
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                Text(recipe.description)
                    .font(.custom(.MontserratRegular, size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Image(.timer)
                    
                    Text(recipe.cookingTime)
                        .font(.custom(.MontserratRegular, size: 14))
                }
                
                Spacer()
                
                Button {
                    favoriteManager.toggleFavorite(recipeTitle: recipe.title)
                } label: {
                    HStack {
                        Image(isFavorite ? .like : .unlike)
                        
                        Text(isFavorite ? "Remove" : "Add to favorites")
                            .font(.custom(.MontserratRegular, size: 10))
                            .foregroundStyle(.black)
                    }
                }
            }
            
            Spacer()
        }
        .padding(12)
        .frame(height: 165)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
