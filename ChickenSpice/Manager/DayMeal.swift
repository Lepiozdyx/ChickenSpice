//
//  DayMeal.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 29.09.2025.
//


import Foundation
import Combine

// WeekMealModel.swift
import Foundation

struct DayMeal: Identifiable, Hashable, Codable {
    var id = UUID()
    let date: Date
    var recipe: Recipe?
    
    var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }
    
    var weekday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    // Для Codable с рецептами
    enum CodingKeys: String, CodingKey {
        case id, date, recipeTitle
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        
        if let recipeTitle = try? container.decode(String.self, forKey: .recipeTitle) {
            recipe = RecipeData.all.first { $0.title == recipeTitle }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(recipe?.title, forKey: .recipeTitle)
    }
    
    init(date: Date, recipe: Recipe? = nil) {
        self.date = date
        self.recipe = recipe
    }
}

class WeekMealManager: ObservableObject {
    @Published var weekMeals: [DayMeal] = []
    @Published var currentWeekIdentifier: String = ""
    
    private let weekMealsKey = "weekMeals"
    private let weekIdentifierKey = "currentWeekIdentifier"
    
    init() {
        loadCurrentWeek()
    }
    
    private func generateWeek() {
        let calendar = Calendar.current
        let today = Date()
        
        // Находим понедельник текущей недели
        guard let monday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else { return }
        
        // Создаем идентификатор недели
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "yyyy-MM-dd"
        currentWeekIdentifier = weekFormatter.string(from: monday)
        
        weekMeals = (0..<7).compactMap { dayOffset in
            guard let date = calendar.date(byAdding: .day, value: dayOffset, to: monday) else { return nil }
            return DayMeal(date: date)
        }
        saveWeekMeals()
    }
    
    func getTodaysMeal() -> Recipe? {
        let today = Date()
        let calendar = Calendar.current
        
        if let todaysMeal = weekMeals.first(where: { calendar.isDate($0.date, inSameDayAs: today) }) {
            return todaysMeal.recipe
        }
        
        return nil
    }
    
    func addRecipe(_ recipe: Recipe, to date: Date) {
        if let index = weekMeals.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            weekMeals[index].recipe = recipe
            saveWeekMeals()
        }
    }
    
    func removeRecipe(from date: Date) {
        if let index = weekMeals.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            weekMeals[index].recipe = nil
            saveWeekMeals()
        }
    }
    
    func fillWeekWithRandomRecipes() {
        let allRecipes = RecipeData.all
        guard !allRecipes.isEmpty else { return }
        
        for index in weekMeals.indices {
            let randomRecipe = allRecipes.randomElement()!
            weekMeals[index].recipe = randomRecipe
        }
        saveWeekMeals()
    }
    
    func clearWeek() {
        for index in weekMeals.indices {
            weekMeals[index].recipe = nil
        }
        saveWeekMeals()
    }
    
    private func saveWeekMeals() {
        do {
            let encodedMeals = try JSONEncoder().encode(weekMeals)
            UserDefaults.standard.set(encodedMeals, forKey: weekMealsKey)
            UserDefaults.standard.set(currentWeekIdentifier, forKey: weekIdentifierKey)
        } catch {
            print("❌ Error saving week meals: \(error)")
        }
    }
    
    private func loadCurrentWeek() {
        let calendar = Calendar.current
        let today = Date()
        
        guard let currentMonday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else { return }
        
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "yyyy-MM-dd"
        let currentWeekId = weekFormatter.string(from: currentMonday)
        
        if let savedWeekId = UserDefaults.standard.string(forKey: weekIdentifierKey),
           let savedData = UserDefaults.standard.data(forKey: weekMealsKey) {
            
            if savedWeekId == currentWeekId {
                do {
                    let decodedMeals = try JSONDecoder().decode([DayMeal].self, from: savedData)
                    weekMeals = decodedMeals
                    currentWeekIdentifier = savedWeekId
                } catch {
                    generateWeek()
                }
            } else {
                clearPreviousWeekData()
                generateWeek()
            }
        } else {
            generateWeek()
        }
    }
    
    private func clearPreviousWeekData() {
        UserDefaults.standard.removeObject(forKey: weekMealsKey)
        UserDefaults.standard.removeObject(forKey: weekIdentifierKey)
        
    }
    
}
