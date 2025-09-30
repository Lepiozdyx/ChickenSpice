//
//  FavoriteManager.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 26.09.2025.
//
import Foundation
import Combine

@MainActor

final class FavoriteManager: ObservableObject {
    @Published var favoriteRecipes: [String] = []
    
    private let favoritesKey = "favoriteRecipes"
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(recipeTitle: String) {
        if favoriteRecipes.contains(recipeTitle) {
            favoriteRecipes.removeAll { $0 == recipeTitle }
        } else {
            favoriteRecipes.append(recipeTitle)
        }
        saveFavorites()
    }
    
    func isFavorite(recipeTitle: String) -> Bool {
        return favoriteRecipes.contains(recipeTitle)
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([String].self, from: data) {
            favoriteRecipes = decoded
        }
    }
    
    func getFavoriteRecipes() -> [Recipe] {
        return RecipeData.all.filter { favoriteRecipes.contains($0.title) }
    }
}
