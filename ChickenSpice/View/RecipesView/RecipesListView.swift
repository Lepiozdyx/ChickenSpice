//
//  RecipesListView.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 26.09.2025.
//

import SwiftUI

struct RecipesListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var favoriteManager: FavoriteManager
    let category: Categories
    
    @State private var searchText = ""
    @State private var showingFilterSheet = false
    @State private var filterOptions = FilterOptions()
    
    var filteredRecipes: [Recipe] {
        let categoryRecipes = RecipeData.all.filter { $0.category == category }
        
        var filtered = categoryRecipes
        
        if !searchText.isEmpty {
            filtered = filtered.filter { recipe in
                recipe.title.localizedCaseInsensitiveContains(searchText) ||
                recipe.description.localizedCaseInsensitiveContains(searchText) ||
                recipe.ingredients.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        if filterOptions.isActive {
            filtered = filtered.filter { recipe in
                let timeMatch = filterOptions.selectedTimes.isEmpty ||
                filterOptions.selectedTimes.contains { selectedTime in
                    let roundedRecipeTime = roundCookingTime(recipe.cookingTime)
                    return roundedRecipeTime == selectedTime
                }
                
                let difficultyMatch = filterOptions.difficulties.isEmpty ||
                filterOptions.difficulties.contains(recipe.difficulty)
                
                let hotMatch = filterOptions.hotLevels.isEmpty ||
                filterOptions.hotLevels.contains(recipe.hot)
                
                return timeMatch && difficultyMatch && hotMatch
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
                
            
                if filteredRecipes.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        
                        if searchText.isEmpty && !filterOptions.isActive {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text("No recipes in this category")
                                .font(.custom(.MontserratSemiBold, size: 16))
                                .foregroundColor(.gray)
                        } else {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text("No recipes found")
                                .font(.custom(.MontserratSemiBold, size: 16))
                                .foregroundColor(.gray)
                            
                            if filterOptions.isActive {
                                Text("Try changing filters")
                                    .font(.custom(.MontserratRegular, size: 14))
                                    .foregroundColor(.gray.opacity(0.7))
                                
                                if !filterOptions.selectedTimes.isEmpty {
                                    Text("Recipes are rounded (40 min → 60 min)")
                                        .font(.custom(.MontserratRegular, size: 12))
                                        .foregroundColor(.gray.opacity(0.7))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 16) {
//                            
                            ForEach(filteredRecipes) { recipe in
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
        .sheet(isPresented: $showingFilterSheet) {
            FilterView(filterOptions: $filterOptions)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(category.title)
                    .font(.custom(.MontserratSemiBold, size: 14))
                    .foregroundStyle(.black)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(.backButton)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingFilterSheet = true
                } label: {
                    Image(.filter)
                }
            }
        }
    }
}

#Preview {
    RecipesListView(category: .chicken)
        .environmentObject(FavoriteManager())
}
