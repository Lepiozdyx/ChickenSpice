//
//  FavView.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 24.09.2025.
//

import SwiftUI

struct FavView: View {
    @EnvironmentObject private var favoriteManager: FavoriteManager
    @State private var searchText = ""
    var filteredReceipts: [Recipe] {
        let favs = RecipeData.all.filter { favoriteManager.favoriteRecipes.contains($0.title)}
        var filtered = favs
        
        if !searchText.isEmpty {
            filtered = filtered.filter { recipe in
                recipe.title.localizedCaseInsensitiveContains(searchText) ||
                recipe.description.localizedCaseInsensitiveContains(searchText) ||
                recipe.ingredients.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        return filtered
    }
    var body: some View {
        ZStack {
            Color.back
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search recipes...", text: $searchText)
                            .font(.custom(.MontserratRegular, size: 17))
                            .padding(.vertical, 6)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.back)
                
            
                if filteredReceipts.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        
                        if searchText.isEmpty {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text("No favorite recipes")
                                .font(.custom(.MontserratSemiBold, size: 16))
                                .foregroundColor(.gray)
                        } else {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text("No recipes found")
                                .font(.custom(.MontserratSemiBold, size: 16))
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 16) {
                            
                            ForEach(filteredReceipts) { recipe in
                                NavigationLink {
                                    RecipeDetailView(recipe: recipe)
                                        .environmentObject(favoriteManager)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    RecipeRow(recipe: recipe)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(16)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
