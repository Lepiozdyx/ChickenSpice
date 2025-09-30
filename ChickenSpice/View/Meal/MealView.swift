//
//  MealView.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 24.09.2025.
//

import SwiftUI

struct MealView: View {
    @EnvironmentObject private var favoriteManager: FavoriteManager
    @EnvironmentObject var weekMealManager: WeekMealManager
    @State private var showingRecipeSelection = false
    @State private var selectedDate: Date?
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(weekMealManager.weekMeals) { dayMeal in
                        if let recipe = dayMeal.recipe {
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                                    .environmentObject(favoriteManager)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                DayMealCard(dayMeal: dayMeal, onAdd: {
                                    selectedDate = dayMeal.date
                                    showingRecipeSelection = true
                                }, onRemove: {
                                    weekMealManager.removeRecipe(from: dayMeal.date)
                                })
                            }
                        } else {
                            DayMealCard(dayMeal: dayMeal, onAdd: {
                                selectedDate = dayMeal.date
                                showingRecipeSelection = true
                            }, onRemove: {
                                weekMealManager.removeRecipe(from: dayMeal.date)
                            })
                        }
                        
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 120)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Week meal")
                    .font(.custom(.MontserratSemiBold, size: 14))
                    .foregroundStyle(.black)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    weekMealManager.fillWeekWithRandomRecipes()
                } label: {
                    Image(.magicpen)
                }
            }
        }
        .overlay(
            Group {
                if showingRecipeSelection {
                    RecipeSelectionModal(
                        isShowing: $showingRecipeSelection,
                        selectedDate: selectedDate,
                        onRecipeSelected: { recipe in
                            if let date = selectedDate {
                                weekMealManager.addRecipe(recipe, to: date)
                            }
                            showingRecipeSelection = false
                        }
                    )
                }
            }
        )
        
    }
}

#Preview {
    MainView()
}

struct DayMealCard: View {
    let dayMeal: DayMeal
    let onAdd: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .center, spacing: 2) {
                Text(dayMeal.dayNumber)
                    .font(.custom(.MontserratBold, size: 44))
                    .foregroundColor(.black)
                
                Text(dayMeal.monthName)
                    .font(.custom(.MontserratBold, size: 12))
                    .foregroundColor(.black)
            }
            
            if let recipe = dayMeal.recipe {
                HStack(spacing: 8) {
                    Image(recipe.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(recipe.title)
                            .font(.custom(.MontserratBold, size: 14))
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.6)
                        Text(recipe.description)
                            .font(.custom(.MontserratRegular, size: 12))
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.3)
                        
                    }
                    
                    Spacer()
                    Button(action: onRemove) {
                        Image(.trash)
                    }
                }
            } else {
                HStack(spacing: 12) {
                    Spacer()
                    Text("Add recipe")
                        .font(.custom(.MontserratRegular, size: 10))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Image(.addcircle)
                        .font(.system(size: 32))
                        .foregroundColor(.blue)
                }
                .onTapGesture(perform: onAdd)
            }
        }
        .frame(height: 95)
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct RecipeSelectionModal: View {
    @Binding var isShowing: Bool
    let selectedDate: Date?
    let onRecipeSelected: (Recipe) -> Void
    
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowing = false
                }
            
            VStack(spacing: 0) {

                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(RecipeData.all) { recipe in
                            RecipeSelectionRow(
                                recipe: recipe,
                                isSelected: selectedRecipe?.id == recipe.id,
                                onSelect: {
                                    selectedRecipe = recipe
                                }
                            )
                        }
                    }
                    .padding(20)
                }
                
                HStack(spacing: 12) {
                    Button("Cancel") {
                        isShowing = false
                    }
                    .font(.custom(.MontserratMedium, size: 16))
                    .foregroundColor(.black)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button("Save") {
                        if let recipe = selectedRecipe {
                            onRecipeSelected(recipe)
                        }
                    }
                    .font(.custom(.MontserratMedium, size: 16))
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(selectedRecipe != nil ? Color.green : Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(selectedRecipe == nil)
                }
                .padding(20)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height * 1/1.8)
            .background(.addingBack)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            .offset(y: -40)
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.3), value: isShowing)
    }
}

struct RecipeSelectionRow: View {
    let recipe: Recipe
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 24) {
                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.title)
                        .font(.custom(.MontserratBold, size: 14))
                        .foregroundColor(.black)
                    
                    HStack {
                        if !isSelected {
                            Text("Add recipe")
                                .font(.custom(.MontserratRegular, size: 10))
                                .foregroundColor(.black)
                                .lineLimit(2)
                            Image(.addcircle)
                        } else {
                            Text("Added")
                                .font(.custom(.MontserratRegular, size: 10))
                                .foregroundColor(.green)
                            Image(.addedcircle)
                        }
                    }
                }
                Spacer()
                
            }
            .padding(12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }
    }
}
