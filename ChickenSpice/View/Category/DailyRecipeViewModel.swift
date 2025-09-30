//
//  DailyRecipeViewModel.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 25.09.2025.
//

import Foundation
import Combine

class DailyRecipeViewModel: ObservableObject {
    @Published var todaysRecipe: Recipe?
    
    private let userDefaultsKey = "lastRecipeDate"
    private let userDefaultsRecipeIndexKey = "lastRecipeIndex"
    
    init() {
        loadTodaysRecipe()
    }
    
    private func loadTodaysRecipe() {
        let calendar = Calendar.current
        
        if let lastDate = UserDefaults.standard.object(forKey: userDefaultsKey) as? Date,
           calendar.isDateInToday(lastDate) {
            
            let lastIndex = UserDefaults.standard.integer(forKey: userDefaultsRecipeIndexKey)
            if lastIndex < RecipeData.all.count {
                todaysRecipe = RecipeData.all[lastIndex]
                return
            }
        }
        
        selectNewDailyRecipe()
    }
    
    private func selectNewDailyRecipe() {
        let calendar = Calendar.current
        let today = Date()
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: today)
        
        if let seed = dateComponents.year, let month = dateComponents.month, let day = dateComponents.day {
            let dailySeed = seed * 10000 + month * 100 + day
            var generator = SeededRandomNumberGenerator(seed: dailySeed)
            
            let randomIndex = Int.random(in: 0..<RecipeData.all.count, using: &generator)
            todaysRecipe = RecipeData.all[randomIndex]
            
            UserDefaults.standard.set(today, forKey: userDefaultsKey)
            UserDefaults.standard.set(randomIndex, forKey: userDefaultsRecipeIndexKey)
        }
        
    }
    
    
//    var isTodaysRecipe: Bool {
//        guard let lastDate = UserDefaults.standard.object(forKey: userDefaultsKey) as? Date else {
//            return false
//        }
//        return Calendar.current.isDateInToday(lastDate)
//    }
//    
//    var lastUpdateDate: Date? {
//        return UserDefaults.standard.object(forKey: userDefaultsKey) as? Date
//    }
}

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var seed: UInt64
    
    init(seed: Int) {
        self.seed = UInt64(truncatingIfNeeded: seed)
    }
    
    mutating func next() -> UInt64 {
        seed = (seed &* 6364136223846793005) &+ 1442695040888963407
        return seed
    }
}

