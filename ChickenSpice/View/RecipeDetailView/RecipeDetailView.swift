//
//  RecipeDetailView.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 26.09.2025.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    let recipe: Recipe
    @State private var isOpenReceipe = true
    @EnvironmentObject private var favoriteManager: FavoriteManager
    
    @State private var checkedIngredients: Set<String> = []

    private var isFavorite: Bool {
        favoriteManager.isFavorite(recipeTitle: recipe.title)
    }
    
    var body: some View {
        
        ZStack {
            Image(recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .clipped()
                .ignoresSafeArea(edges: .bottom)
            
            
            ZStack {
                VStack() {
                    Text(recipe.title)
                        .foregroundStyle(.white)
                        .font(.custom(.MontserratBold, size: 24))
                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                        .padding(.bottom)
                    HStack {
                        Image(.timer)
                        Text(recipe.cookingTime)
                        Spacer()
                        
                        Image(.difficulty)
                        Text(recipe.difficulty.rawValue)
                        
                        Spacer()
                        
                        HStack(spacing: 2) {
                            ForEach(1...3, id: \.self) { level in
                                Image(level <= recipe.hot.rawValue ? "Chilli" : "ChilliNone")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                            }
                        }
                        
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundStyle(.grayBack)
                    }
                    .padding(.bottom, UIScreen.main.bounds.height / 10)
                    
                    
                    
                    ScrollView() {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("How to cook")
                                .font(.custom(.MontserratBold, size: 20))
                                .foregroundColor(.black)
                                .padding(.horizontal, 24)
                                .padding(.top, 8)
                            
                            ForEach(recipe.steps) { step in
                                HStack(alignment: .top, spacing: 16) {
                                    Text("\(step.id)")
                                        .font(.custom(.MontserratRegular, size: 14))
                                        .foregroundColor(.black)
                                    
                                    
                                    Text(step.description)
                                        .font(.custom(.MontserratRegular, size: 14))
                                        .foregroundColor(.black)
                                    
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Ingredients")
                                    .font(.custom(.MontserratBold, size: 20))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 24)
                                    .padding(.top, 8)
                                
                                ForEach(recipe.ingredients, id: \.self) { ingredient in
                                    Button(action: {
                                        
                                        if checkedIngredients.contains(ingredient) {
                                            checkedIngredients.remove(ingredient)
                                        } else {
                                            checkedIngredients.insert(ingredient)
                                        }
                                    }) {
                                        HStack(alignment: .top, spacing: 16) {
                                            // Чекбокс
                                            Image(checkedIngredients.contains(ingredient) ? "selected" : "unselected")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .padding(.top, 2) //
                                            Text(ingredient)
                                                .font(.custom(.MontserratRegular, size: 14))
                                                .foregroundColor(checkedIngredients.contains(ingredient) ? .gray : .black)
                                                .strikethrough(checkedIngredients.contains(ingredient)) // Зачеркивание
                                                .multilineTextAlignment(.leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                            
                                            Spacer()
                                        }
                                        .contentShape(Rectangle()) // Кликабельная область на весь элемент
                                    }
                                    .buttonStyle(PlainButtonStyle()) // Убираем стиль кнопки
                                    .padding(.horizontal, 24)
                                }
                            }
                            .padding(.bottom, 8)

                            
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .background(Color.white)
                }
                .padding(24)
                .ignoresSafeArea(edges: .bottom)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Recipe")
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
                    favoriteManager.toggleFavorite(recipeTitle: recipe.title)
                } label: {
                    Image(favoriteManager.isFavorite(recipeTitle: recipe.title) ? .like : .unlike)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: RecipeData.all[0])
            .environmentObject(FavoriteManager())
    }
}
