//
//  Categories.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 24.09.2025.
//

import Foundation
import SwiftUI

enum Categories: CaseIterable, Hashable, Codable {
    case tacos, tortillas, soups, chicken
    
    var title: String {
        switch self {
        case .tacos: return "Tacos"
        case .tortillas: return "Tortillas"
        case .soups: return "Soups"
        case .chicken: return "Chicken"
        }
    }
    
    var icon: String {
        switch self {
        case .tacos: return "chicken_burrito_chipotle_crema"
        case .tortillas: return "half_and_half_tortillas"
        case .soups: return "roasted_poblano_soup"
        case .chicken: return "Hatch"
        }
    }
}

enum Hot: Int, CaseIterable, Hashable, Codable {
    case one = 1, two = 2, three = 3
}

enum RecipeDifficulty: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case hard = "Hard"
}


struct RecipeStep: Identifiable, Codable, Hashable {
    let id: Int
    let description: String
}

struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    let category: Categories
    let title: String
    let description: String
    let imageName: String
    let cookingTime: String
    let difficulty: RecipeDifficulty
    let hot: Hot
    
    let ingredients: [String]
    let steps: [RecipeStep]
    
    init(
        id: UUID = UUID(),
        category: Categories,
        title: String,
        description: String,
        imageName: String,
        cookingTime: String,
        difficulty: RecipeDifficulty,
        hot: Hot,
        ingredients: [String],
        steps: [RecipeStep]
    ) {
        self.id = id
        self.category = category
        self.title = title
        self.description = description
        self.imageName = imageName
        self.cookingTime = cookingTime
        self.difficulty = difficulty
        self.hot = hot
        self.ingredients = ingredients
        self.steps = steps
    }
}

struct RecipeData {
    static let all: [Recipe] = [
        Recipe(
            category: .chicken,
            title: "Hatch Chicken Chile Verde",
            description: "Make a big batch of this Hatch Chicken Chile Verde and you'll be in Hatch Heaven over the coming days. ",
            imageName: "Hatch",
            cookingTime: "00:30",
            difficulty: .medium,
            hot: .one,
            ingredients: [
                "2-2.5 lbs. Hatch chiles",
                "2 lbs. chicken",
                "1/2 onion",
                "4 garlic cloves",
                "1 cup stock",
                "1 tablespoon Mexican oregano",
                "1/4 teaspoon cumin (optional)",
                "1/4 teaspoon salt",
                "freshly cracked black pepper",
                "olive oil"
            ],
            steps: [
                RecipeStep(id: 1, description: "Start by giving the Hatch chiles a good rinse. Then place them on a baking sheet and roast them in the oven (400F) for a half hour or so. I usually check on them halfway through the baking period and give them a flip."),
                RecipeStep(id: 2, description: "As the chiles roast I usually brine the chicken. Add 1/2 cup Kosher or sea salt to a mixing bowl along with 2 quarts of cold water. Stir to dissolve the salt and then add the chicken breasts. Cover and let brine in the fridge for 30-60 minutes or until you need it."),
                RecipeStep(id: 3, description: "You can start baking the chicken when the chiles are close to being done. Remove the chicken from the brine and pat dry. Add the chicken to a baking sheet and bake in the oven (400F) for 20 minutes or until the internal temp reaches 160F."),
                RecipeStep(id: 4, description: "Let the chiles cool for a couple minutes after roasting, then de-stem and de-seed them. Don't worry about getting rid of every last seed, just get the majority out. You can also discard any puffy bits of skin but you don't need to remove all of it. Add the chile pieces to a blender along with: 1 cup stock, 1/4 onion, 2 peeled garlic cloves. Combine well. You may have to blend half of the chiles before you can fit the other half in the blender."),
                RecipeStep(id: 5, description: "Finely dice the remaining 1/4 onion and 2 garlic cloves. Saute the onion in a glug of oil over medium heat in a large skillet or saucepan. When the onion has softened add the minced garlic and cook briefly. Then add the Hatch sauce from the blender along with: 1 tablespoon Mexican oregano, 1/4 teaspoon cumin (optional), 1/4 teaspoon salt, freshly cracked black pepper. Bring this mixture up to temp over medium heat, stirring regularly."),
                RecipeStep(id: 6, description: "When the chicken has finished baking, usually about 20 minutes, remove it from the oven and let it rest for a couple minutes. Then shred it with two forks and add it to the Hatch mixture in the pan. Combine well and take a final taste for seasoning. I've found that when I use brined chicken I don't need to add much salt, but if you're skipping the brine or using rotisserie chicken then you may need to add some additional salt at this point."),
                RecipeStep(id: 7, description: "Your Hatch Chicken Chile Verde is already loaded with flavor so feel free to serve it up as you see fit! Even a big spoonful over white rice is a quick, satisfying meal that I frequently munch on"),
                RecipeStep(id: 8, description: "If you want to make the Tostadas, start by warming up the tostada shells in the oven for a few minutes. I usually warm up the refried beans too. Then load up each tostada shell with a thin layer of refried beans, plenty of Hatch Chicken, Queso Fresco, freshly chopped cilantro, and a squeeze of lime."),
                RecipeStep(id: 9, description: "Store leftover Hatch Chicken Chile Verde in the fridge where it will keep for a few day"),
            ]
        ),
        
        Recipe(
            category: .chicken,
            title: "Chicken Chile Verde",
            description: "Juicy chicken breasts cooked with roasted tomatillos, poblanos, and jalapeños in a flavorful green sauce.",
            imageName: "chicken_chile_verde",
            cookingTime: "00:40",
            difficulty: .medium,
            hot: .three, 
            ingredients: [
                "2 lbs. chicken (3 boneless chicken breasts)",
                "8-10 tomatillos",
                "1 large poblano (or 2 smaller ones)",
                "1-4 jalapeños",
                "1/2 onion",
                "4 garlic cloves",
                "15-20 sprigs cilantro",
                "1 tablespoon Mexican oregano",
                "1/2 teaspoon cumin (optional)",
                "1/2 teaspoon salt (optional)",
                "freshly cracked black pepper"
            ],
            steps: [
                RecipeStep(id: 1, description: "Brine the chicken: dissolve 1/2 cup Kosher or sea salt in 2 quarts of cold water, add chicken breasts, and refrigerate for 30-60 minutes. If needed, add more water so the chicken is fully submerged."),
                RecipeStep(id: 2, description: "Pat dry the brined chicken and place it on a baking sheet."),
                RecipeStep(id: 3, description: "Remove husks from tomatillos, rinse well, de-stem, and place them on the baking sheet with the chicken and poblano peppers."),
                RecipeStep(id: 4, description: "Roast in the oven at 400F: bake chicken until internal temp reaches 160F (about 20 minutes). Remove chicken and cover with foil. Let tomatillos and poblanos roast an extra 10 minutes."),
                RecipeStep(id: 5, description: "De-stem and de-seed the roasted poblanos. Add roasted poblanos and tomatillos to a blender with 1/2 onion, 4 peeled garlic cloves, 15-20 sprigs of cilantro, and 1-4 de-stemmed jalapeños. Blend until smooth. Adjust jalapeños based on heat preference."),
                RecipeStep(id: 6, description: "Simmer the green sauce in a bit of oil over medium heat. Stir in 1 tablespoon Mexican oregano, 1/2 teaspoon cumin (optional), 1/2 teaspoon salt (optional), and freshly cracked black pepper. Taste and adjust seasoning."),
                RecipeStep(id: 7, description: "Shred the chicken breasts with two forks and add them into the simmering green sauce. Mix well and bring everything to serving temperature."),
                RecipeStep(id: 8, description: "Serve immediately with rice, tortillas, or tostadas. For tostada style: spread refried beans on a tostada shell, add Chicken Chile Verde, cheese, cilantro, and a squeeze of lime."),
                RecipeStep(id: 9, description: "Store leftovers in an airtight container in the fridge for up to a few days.")
            ]
        ),
        
        Recipe(
            category: .chicken,
            title: "Mexican Chicken and Rice – Arroz con Pollo",
            description: "The most satisfying one-pot meal! Juicy chicken thighs and flavorful rice cooked together with roasted tomatoes, onion, garlic, and jalapeño.",
            imageName: "mexican_chicken_rice",
            cookingTime: "01:00",
            difficulty: .medium,
            hot: .two, // Добавлено: содержит jalapeño
            ingredients: [
                "2-3 lbs. chicken (5 bone-in chicken thighs)",
                "2 cups uncooked rice",
                "3 cups stock (or water)",
                "3 plum tomatoes",
                "1/2 small onion",
                "2 garlic cloves",
                "1 jalapeño",
                "1 tablespoon Mexican oregano",
                "1/4 teaspoon cumin (optional)",
                "0-1 teaspoons salt (to taste)",
                "freshly cracked black pepper",
                "freshly chopped cilantro (optional)",
                "olive oil"
            ],
            steps: [
                RecipeStep(id: 1, description: "Optional: brine the chicken. Dissolve 1/2 cup Kosher salt in 2 quarts cold water. Add chicken thighs, cover, and refrigerate 30–60 minutes."),
                RecipeStep(id: 2, description: "Rinse and de-stem 3 plum tomatoes. Roast in the oven at 400F for about 30 minutes."),
                RecipeStep(id: 3, description: "Remove chicken from brine, pat dry. Heat 2–3 tbsp olive oil in a deep skillet over medium-high heat. Brown chicken on both sides (start skin-side down). Set aside once browned."),
                RecipeStep(id: 4, description: "In the same skillet, add 2 cups uncooked rice. Cook over medium heat, stirring regularly, until turning opaque and lightly browned."),
                RecipeStep(id: 5, description: "Blend roasted tomatoes, 1/2 onion, 2 garlic cloves, and 1 jalapeño until smooth. (Use less jalapeño for a milder version.)"),
                RecipeStep(id: 6, description: "Add blended tomato mixture to the rice. Cook for 2 minutes, stirring regularly. Then add 3 cups stock, 1 tbsp Mexican oregano, 1/4 tsp cumin (optional), black pepper, and salt (if needed)."),
                RecipeStep(id: 7, description: "Taste the mixture before simmering to adjust salt. Store-bought stock may need little salt, water may need up to 1 tsp."),
                RecipeStep(id: 8, description: "Return browned chicken to the pan. Bring to boil, then reduce heat to low. Cover and simmer 20–25 minutes."),
                RecipeStep(id: 9, description: "When liquid is absorbed (around 20 minutes), remove from heat and let rest, covered, for a few minutes."),
                RecipeStep(id: 10, description: "Serve chicken pieces over rice. Optionally top with fresh cilantro."),
                RecipeStep(id: 11, description: "Store leftovers in fridge for a few days. Rice can be reused in burritos, tacos, tostadas, or mixed with beans.")
            ]
        ),
        
        Recipe(
            category: .chicken,
            title: "Spicy Chicken and Pickled Jalapeno Pizza",
            description: "Mexican-inspired pizza with spicy chicken, garlic-oil sauce, and pickled jalapenos. Easy to make without special pizza gear.",
            imageName: "spicy_chicken_jalapeno_pizza",
            cookingTime: "01:00",
            difficulty: .hard,
            hot: .two, // Добавлено: содержит pickled jalapenos
            ingredients: [
                "1 cup pickled jalapenos",
                "1 cup cubed Mozzarella cheese",
                "— For the pizza dough:",
                "2 cups all-purpose unbleached flour",
                "3/4 cup warm water",
                "1 teaspoon yeast",
                "1 teaspoon salt",
                "— For the chicken:",
                "1 chicken breast",
                "1 tablespoon crushed New Mexican chile (or chile powder of choice)",
                "1/2 teaspoon chipotle powder (optional)",
                "1/4 teaspoon salt",
                "freshly ground pepper",
                "1 tablespoon olive oil",
                "— For the garlic-oil sauce:",
                "2 tablespoons olive oil",
                "2 garlic cloves, minced",
                "pinch of salt"
            ],
            steps: [
                RecipeStep(id: 1, description: "Make the dough: dissolve 1 tsp yeast in 3/4 cup warm water. Add 2 cups flour and 1 tsp salt. Mix, then knead on a work surface until smooth. Cover and let rise 1–2 hours (or 30 minutes for faster version)."),
                RecipeStep(id: 2, description: "Prepare garlic-oil sauce: mince 2 garlic cloves. Mix with 2 tbsp olive oil and pinch of salt. Press garlic into oil with spoon to infuse flavor."),
                RecipeStep(id: 3, description: "Prepare chicken: chop breast into bite-sized pieces. Season with chile powder, chipotle (optional), salt, pepper, and 1 tbsp olive oil. Sauté over medium-high heat until cooked. Set aside."),
                RecipeStep(id: 4, description: "Divide dough: tear into halves, then one half into half again (enough for a thin 10\" crust). Roll out dough, let rest a few minutes, then roll again to desired thinness. Roll on parchment for easier handling."),
                RecipeStep(id: 5, description: "Pre-bake dough: place rolled dough in oven at 400F for 1–2 minutes."),
                RecipeStep(id: 6, description: "Assemble pizza: spread thin garlic-oil sauce layer, add chicken, mozzarella, and pickled jalapenos."),
                RecipeStep(id: 7, description: "Bake at 400F for 8–10 minutes until edges brown."),
                RecipeStep(id: 8, description: "Serve immediately. Optionally garnish with cilantro, Crema, and extra jalapenos.")
            ]
        ),
        
        Recipe(
            category: .chicken,
            title: "Arroz Con Pollo with Wings and Chipotles",
            description: "This shortcut version of Arroz con Pollo uses chicken wings and chipotles for a quick but flavorful meal.",
            imageName: "arroz_wings_chipotles",
            cookingTime: "00:30",
            difficulty: .low,
            hot: .two, // Добавлено: содержит chipotles
            ingredients: [
                "4-6 chicken wings (approx. 1/2 lb.)",
                "1-2 plum tomatoes",
                "1/2 cup uncooked white rice",
                "1 cup stock",
                "1/4 onion",
                "1 garlic clove",
                "1-2 chipotles in adobo (or less for a milder version)",
                "1 teaspoon Mexican oregano",
                "pinch of cumin (optional)",
                "1/4 teaspoon salt",
                "freshly cracked black pepper",
                "olive oil"
            ],
            steps: [
                RecipeStep(id: 1, description: "Heat oil over medium-high in a saucepan. Add chicken wings and brown each side for a few minutes. Remove and set aside."),
                RecipeStep(id: 2, description: "Add 1/2 cup uncooked rice to the same pan. Stir and cook over medium heat until rice turns golden brown."),
                RecipeStep(id: 3, description: "Blend together 1–2 plum tomatoes (rinsed, de-stemmed), 1/4 onion, 1 garlic clove, и 1–2 chipotles in adobo. Use less chipotle for a milder version. (Optional: remove chipotle seeds)."),
                RecipeStep(id: 4, description: "Add the blended mixture to the pan with rice. Simmer a few minutes, stirring regularly."),
                RecipeStep(id: 5, description: "Add 1 tsp oregano, pinch of cumin (optional), 1/4 tsp salt, freshly cracked black pepper, and 1 cup stock. Stir well and bring to boil. Taste for salt and adjust if needed."),
                RecipeStep(id: 6, description: "Return browned chicken wings to the pan. Bring to boil, then cover and reduce heat to low. Simmer 20–25 minutes until liquid is absorbed."),
                RecipeStep(id: 7, description: "Remove from heat, keep covered, and let rest in steam for a few minutes. Serve and enjoy!")
            ]
        ),
        
        Recipe(
            category: .tacos,
            title: "Quick Chicken Burrito with Chipotle Crema",
            description: "A fast and easy burrito recipe with creamy, smoky chipotle sauce. Perfect for rushed weeknights!",
            imageName: "chicken_burrito_chipotle_crema",
            cookingTime: "00:25",
            difficulty: .low,
            hot: .one, // Добавлено: содержит chipotle crema
            ingredients: [
                "1 chicken breast",
                "1 cup refried beans",
                "1–2 cups cooked white rice",
                "3 flour tortillas (burrito sized)",
                "1 cup shredded cheese",
                "freshly chopped cilantro",
                
                "1 cup mayonnaise or plain Greek yogurt (or a combo)",
                "2 chipotles in adobo",
                "2 garlic cloves",
                "1–2 tbsp adobo sauce (from can)",
                "squeeze of lime",
                "pinch of salt"
            ],
            steps: [
                RecipeStep(id: 1, description: "Make the Chipotle Crema: blend mayonnaise or Greek yogurt (or combo), chipotles in adobo, adobo sauce, garlic cloves, lime juice, and pinch of salt. Optionally scrape seeds from chipotles. Add splash of water if needed."),
                RecipeStep(id: 2, description: "Cook the chicken breast: season and chop, then sauté with some onion until fully cooked."),
                RecipeStep(id: 3, description: "If needed, cook the rice: sauté 1 cup uncooked rice in oil until lightly golden, add 1.5 cups water or stock with 1/2 tsp salt, cover and simmer until liquid is absorbed."),
                RecipeStep(id: 4, description: "Warm tortillas in a skillet to make rolling easier."),
                RecipeStep(id: 5, description: "Build each burrito: spread a thin layer of refried beans, add cooked rice, shredded cheese, chicken pieces, and chopped cilantro."),
                RecipeStep(id: 6, description: "Roll burritos tightly. Optionally crisp them in a skillet with lard, bacon drippings, or dry heat."),
                RecipeStep(id: 7, description: "Serve with Chipotle Crema either inside or drizzled on top. Enjoy immediately!")
            ]
        ),
        
        Recipe(
            category: .tacos,
            title: "Baja Fish Tacos with Chipotle Crema and Curtido",
            description: "Crispy fried fish wrapped in warm corn tortillas, topped with smoky chipotle crema and zesty pickled cabbage. A Baja classic!",
            imageName: "baja_fish_tacos",
            cookingTime: "01:00",
            difficulty: .medium,
            hot: .one, // Добавлено: содержит chipotle crema
            ingredients: [
                // Рыба и тесто
                "450 g white fish (cod, tilapia, hake)",
                "1 cup all-purpose flour",
                "1 cup beer (light lager)",
                "1 tsp baking powder",
                "1 tsp salt",
                "freshly cracked black pepper",
                "1 tsp chile powder (optional)",
                "10–12 corn tortillas",
                "2–3 limes",
                "3–4 cups frying oil (canola or sunflower)",
                
                // Chipotle Crema
                "1 cup mayonnaise (or half mayo, half Greek yogurt)",
                "2 chipotles in adobo",
                "1 tbsp adobo sauce (from can)",
                "2 garlic cloves",
                "squeeze of lime",
                "pinch of salt",
                
                // Curtido (pickled cabbage)
                "1/3 head green cabbage",
                "1/4 onion",
                "1/4 jalapeño",
                "1/2 cup vinegar",
                "3/4 cup water",
                "1 tsp salt (preferably kosher/sea salt)",
                "1/2 tsp Mexican oregano (optional)",
                "freshly cracked black pepper"
            ],
            steps: [
                RecipeStep(id: 1, description: "Prepare the Curtido: thinly slice cabbage, onion, and jalapeño. Mix with vinegar, water, oregano, salt, and pepper. Transfer to a jar, shake, and refrigerate until needed."),
                RecipeStep(id: 2, description: "Make the Chipotle Crema: blend mayonnaise (or half mayo + half yogurt), chipotles, adobo sauce, garlic, lime juice, and salt until smooth. Add a splash of water if needed."),
                RecipeStep(id: 3, description: "Pat fish dry, season with salt, and cut into strips about 1×3 inches."),
                RecipeStep(id: 4, description: "Mix the beer batter: whisk together flour, baking powder, salt, pepper, and chile powder (optional). Add beer gradually until consistency is like thick paint."),
                RecipeStep(id: 5, description: "Heat oil to 175–180°C (350–360°F). Dip each fish strip in batter and fry 3–4 minutes until golden brown. Drain on paper towels or wire rack."),
                RecipeStep(id: 6, description: "Warm the corn tortillas in a dry skillet, oven, or microwave."),
                RecipeStep(id: 7, description: "Assemble tacos: place fried fish in tortilla, top with Curtido, drizzle Chipotle Crema, and finish with a squeeze of lime. Serve immediately.")
            ]
        ),
        
        Recipe(
            category: .tacos,
            title: "Tinga Tostadas",
            description: "Crunchy tostadas topped with smoky, spicy Chicken Tinga, beans, cheese, and fresh garnishes. A family favorite with tomatillos for extra flavor!",
            imageName: "tinga_tostadas",
            cookingTime: "00:20",
            difficulty: .medium,
            hot: .two, // Добавлено: содержит chipotles
            ingredients: [
                "8–10 tostadas",
                "refried beans (optional)",
                "Queso Fresco or Cotija cheese (optional)",
                "Mexican Crema (optional)",
                "freshly chopped cilantro (optional)",
                "lime wedges",
                "1/4 cup salt (for brining)",
                
                "2 chicken breasts",
                "2 plum tomatoes",
                "4–5 tomatillos",
                "1/2 onion",
                "4 garlic cloves",
                "3 chipotles in adobo",
                "1–2 tbsp adobo sauce (optional)",
                "1 tsp Mexican oregano",
                "dash of cumin (optional)",
                "1/2 tsp salt (plus more to taste)",
                "freshly cracked black pepper",
                "olive oil"
            ],
            steps: [
                RecipeStep(id: 1, description: "Brine the chicken: dissolve 1/4 cup salt in 1 quart water. Submerge chicken breasts and refrigerate for 30 minutes. Pat dry afterward."),
                RecipeStep(id: 2, description: "Bake chicken with tomatoes and tomatillos at 200°C (400°F) for about 20 minutes, until chicken reaches 71°C (160°F)."),
                RecipeStep(id: 3, description: "Shred the baked chicken with two forks and set aside."),
                RecipeStep(id: 4, description: "Sauté chopped onion and whole garlic cloves in oil over medium heat until lightly browned."),
                RecipeStep(id: 5, description: "Blend sautéed onion-garlic mix with roasted tomatoes, tomatillos, and 3 chipotles. Optionally remove chipotle seeds. Adjust heat by adding more chipotles."),
                RecipeStep(id: 6, description: "Pour sauce back into skillet. Add oregano, cumin (optional), salt, black pepper, and adobo sauce (optional). Simmer and adjust seasoning."),
                RecipeStep(id: 7, description: "Stir in shredded chicken and simmer until evenly heated."),
                RecipeStep(id: 8, description: "Warm tostadas in oven for 2–3 minutes."),
                RecipeStep(id: 9, description: "Assemble: spread refried beans, add Chicken Tinga, then garnish with cheese, crema, cilantro, and lime juice. Serve immediately.")
            ]
        ),
        
        Recipe(
            category: .tacos,
            title: "Birria de Res — Beef Birria",
            description: "A rich and flavorful Mexican beef stew made with dried chiles, spices, and slow-cooked beef. Perfect for tacos, soups, or on-the-fly meals!",
            imageName: "birria_de_res",
            cookingTime: "06:30",
            difficulty: .hard,
            hot: .three, // Добавлено: содержит много острых перцев
            ingredients: [
                "3 lbs beef brisket or chuck roast",
                "4–5 Roma tomatoes",
                "1 onion",
                "6 garlic cloves",
                "3–4 Ancho dried chiles",
                "2–3 New Mexican dried chiles",
                "2 chipotles in adobo (optional)",
                "1–2 tbsp adobo sauce (optional, from the can)",
                "2 cups stock",
                "1 tsp cumin",
                "2 tsp Mexican oregano",
                "1/8 tsp cinnamon",
                "pinch of ground clove",
                "2 tsp salt (plus more to taste)",
                "freshly cracked black pepper",
                "olive oil",
                
                "corn tortillas",
                "Salsa de Aguacate",
                "finely chopped raw onion",
                "freshly chopped cilantro",
                "squeeze of lime"
            ],
            steps: [
                RecipeStep(id: 1, description: "Roast Roma tomatoes in oven at 200°C (400°F) for 20–25 minutes."),
                RecipeStep(id: 2, description: "De-stem and de-seed dried chiles. Roast them in oven for 1–2 minutes until fragrant, then soak in hot water for ~20 minutes."),
                RecipeStep(id: 3, description: "Sauté chopped onion and whole garlic cloves in oil over medium heat until softened and lightly browned. Add to blender."),
                RecipeStep(id: 4, description: "Chop beef into chunks, season with salt, and sear on all sides in hot skillet with oil. Transfer meat to slow cooker. Optionally deglaze skillet with 2 cups stock."),
                RecipeStep(id: 5, description: "Blend drained chiles, roasted tomatoes, sautéed onion-garlic, stock (or soaking liquid), chipotles (optional), adobo sauce, cumin, oregano, cinnamon, clove, salt, and black pepper into a smooth sauce."),
                RecipeStep(id: 6, description: "Taste and adjust sauce for salt and heat. Pour sauce over seared beef in slow cooker."),
                RecipeStep(id: 7, description: "Cook on low for 4–6 hours until beef is tender. Skim fat if desired."),
                RecipeStep(id: 8, description: "Shred beef with forks, discarding excess fat. Mix shredded beef with sauce until fully coated."),
                RecipeStep(id: 9, description: "Serve soup-style with beef in broth (thin with stock if needed) or use as taco filling."),
                RecipeStep(id: 10, description: "For tacos: heat tortillas in skillet with cheese until lightly browned, add beef, then garnish with Salsa de Aguacate, raw onion, cilantro, and lime. Enjoy!"),
                RecipeStep(id: 11, description: "Store leftovers in fridge for a few days.")
            ]
        ),
        
        Recipe(
            category: .tacos,
            title: "Chicken Tacos with Avocado Salsa Verde",
            description: "Simple and satisfying tacos with juicy chicken, refried beans, melted cheese, and a creamy Avocado Salsa Verde.",
            imageName: "chicken_tacos_avocado_salsa_verde",
            cookingTime: "00:30",
            difficulty: .low,
            hot: .one, // Добавлено: содержит jalapeño в сальсе
            ingredients: [
                "1 chicken breast",
                "1/2 cup refried beans",
                "1/2 cup cheese (Jack or similar)",
                "6–8 corn tortillas",
                "freshly chopped cilantro",
                "hot sauce",
                
                "4–5 tomatillos",
                "1/2 small onion",
                "1 garlic clove",
                "1 jalapeno (start with less for milder heat)",
                "10–12 sprigs fresh cilantro",
                "1 ripe avocado",
                "pinch of salt (optional)"
            ],
            steps: [
                RecipeStep(id: 1, description: "De-husk and rinse the tomatillos, removing stems. Roast in the oven at 400°F (200°C) for ~15 minutes until slightly charred. (Alternatively, pan roast or broil)."),
                RecipeStep(id: 2, description: "Blend roasted tomatillos with onion, garlic, jalapeno, and cilantro until smooth. Adjust heat by adding more jalapeno to taste. Add avocado flesh and blend again. Optionally season with salt."),
                RecipeStep(id: 3, description: "Prepare chicken: chop the chicken breast, season with salt, pepper, chile powder, and a drizzle of oil. Cook with slivers of onion in a skillet until fully cooked."),
                RecipeStep(id: 4, description: "Warm tortillas: add a few drops of oil to a skillet and rub tortillas lightly. Heat until pliable and slightly crisp, with light brown spots."),
                RecipeStep(id: 5, description: "Assemble tacos: spread refried beans, sprinkle cheese, and add chicken pieces onto each tortilla. Heat until cheese begins to melt."),
                RecipeStep(id: 6, description: "Top generously with Avocado Salsa Verde, chopped cilantro, and hot sauce. Serve immediately and enjoy!")
            ]
        ),
        
        Recipe(
            category: .tacos,
            title: "Ground Beef Tostadas with Salsa de Aguacate",
            description: "Quick and flavorful tostadas with seasoned ground beef and creamy avocado salsa.",
            imageName: "ground_beef_tostadas_salsa_de_aguacate",
            cookingTime: "00:30",
            difficulty: .low,
            hot: .two, // Добавлено: содержит chipotles
            ingredients: [
                "1 lb. ground beef",
                "1/2 small onion, finely chopped",
                "2 garlic cloves, minced",
                "1–2 chipotles in adobo",
                "1–2 tbsp adobo sauce",
                "1 tbsp chile powder (optional)",
                "2–3 tsp Mexican oregano",
                "1/4 tsp cumin",
                "3/4 tsp salt (plus more to taste)",
                "freshly cracked black pepper",
                "splash of water",
                
                "1 avocado",
                "1/2 garlic clove",
                "juice of 1 lime",
                "1/4 tsp salt",
                "1/4 cup water",
                "4–5 sprigs cilantro",
                
                "1 cup refried beans",
                "1 cup shredded cheese (Jack or similar)",
                "freshly chopped cilantro",
                "6–8 tostada shells"
            ],
            steps: [
                RecipeStep(id: 1, description: "Make the Salsa de Aguacate: blend avocado, 1/2 garlic clove, cilantro, lime juice, 1/4 cup water, and salt until smooth. Add more water if needed."),
                RecipeStep(id: 2, description: "Cook the ground beef: sweat chopped onion in oil over medium heat until softened. Add ground beef and cook until browned. Drain excess fat if desired."),
                RecipeStep(id: 3, description: "Add remaining ingredients to beef: garlic, diced chipotles, adobo sauce, chile powder, cumin, oregano, salt, pepper, and a splash of water. Mix well and taste for seasoning. Keep warm on low heat."),
                RecipeStep(id: 4, description: "Prepare tostada shells: rub a thin layer of oil on each side of corn tortillas and bake 4–5 minutes per side at 400°F until crispy. Alternatively, use store-bought tostada shells and warm them."),
                RecipeStep(id: 5, description: "Assemble tostadas: spread a thin layer of refried beans on each shell, top with ground beef, shredded cheese, chopped cilantro, and a generous amount of Salsa de Aguacate."),
                RecipeStep(id: 6, description: "Optionally squeeze some fresh lime over each tostada and serve immediately. Enjoy!")
            ]
        ),
        
        Recipe(
            category: .tacos,
            title: "Bean and Rice Tostadas with Tomato Tomatillo Salsa",
            description: "Crispy tostadas layered with beans, rice, avocado, cheese, and a fresh tomato-tomatillo salsa. Perfect for a quick Mexican meal!",
            imageName: "bean_rice_tostadas_tomato_tomatillo_salsa",
            cookingTime: "00:30",
            difficulty: .low,
            hot: .one, // Добавлено: содержит jalapeño
            ingredients: [
                "4–5 tomatillos",
                "2 plum tomatoes",
                "1/3 small onion",
                "1 garlic clove",
                "1 jalapeno or serrano",
                "10–12 sprigs cilantro",
                "squeeze of lime",
                "pinch of salt",
                
                "1 cup refried beans",
                "1 cup cooked white rice",
                "1 avocado, diced",
                "6–8 tostada shells",
                "1 cup crumbled or shredded cheese (Queso Fresco)",
                "freshly chopped cilantro",
                "lime wedges"
            ],
            steps: [
                RecipeStep(id: 1, description: "Prepare the Tomato Tomatillo Salsa: de-husk tomatillos, rinse tomatillos and tomatoes, de-stem if desired. Roast in oven at 400°F for ~20 minutes."),
                RecipeStep(id: 2, description: "Blend roasted tomatillos and tomatoes with 1/3 small onion, garlic, jalapeno, cilantro, lime juice, and a pinch of salt until smooth. Adjust jalapeno for desired heat."),
                RecipeStep(id: 3, description: "Warm refried beans and cooked rice. Prepare avocado, cheese, and chop cilantro."),
                RecipeStep(id: 4, description: "Warm tostada shells in oven or store-bought. Spread a thin layer of refried beans on each shell."),
                RecipeStep(id: 5, description: "Add a couple tablespoons of rice, avocado bits, crumbled cheese, chopped cilantro, and a generous amount of Tomato Tomatillo Salsa."),
                RecipeStep(id: 6, description: "Finish with a squeeze of lime and serve immediately. Store leftover salsa in fridge for a few days.")
            ]
        ),
        
        Recipe(
            category: .tortillas,
            title: "Half and Half Tortillas (Corn + Flour)",
            description: "Soft and flavorful tortillas made with a mix of masa harina and all-purpose flour. Perfect for tacos, burritos, or just dipping!",
            imageName: "half_and_half_tortillas",
            cookingTime: "00:30",
            difficulty: .low,
            hot: .one, // Добавлено: нейтральные тортильи
            ingredients: [
                "1 cup Masa Harina",
                "1 cup all-purpose flour",
                "2 tablespoons lard or fat of your choice",
                "1/2 teaspoon salt",
                "3/4 cup warm water (plus more if needed)"
            ],
            steps: [
                RecipeStep(id: 1, description: "Combine masa harina, flour, and salt in a mixing bowl."),
                RecipeStep(id: 2, description: "Add lard and crumble into the mixture using your hands."),
                RecipeStep(id: 3, description: "Pour in 3/4 cup warm water and mix with a spoon until partially combined."),
                RecipeStep(id: 4, description: "Dump mixture onto a work surface and knead until a cohesive dough forms. Adjust with extra water or masa harina if needed."),
                RecipeStep(id: 5, description: "Cover dough with a damp paper towel and let rest for 10 minutes while heating a dry skillet or comal over medium heat."),
                RecipeStep(id: 6, description: "Portion out golfball-sized chunks of dough, roll them between your hands, and flatten with plastic wrap or a dish. Optionally roll thinner with a rolling pin."),
                RecipeStep(id: 7, description: "Peel plastic off and cook tortilla on preheated skillet: flip after 10 seconds, then cook each side 45–60 seconds until light brown spots form."),
                RecipeStep(id: 8, description: "Repeat with remaining dough, rolling out next tortilla while the previous cooks."),
                RecipeStep(id: 9, description: "Store leftover tortillas in an airtight bag in the fridge. Reheat in a dry skillet until warm.")
            ]
        ),
        
        Recipe(
            category: .tortillas,
            title: "Quick Lunch with Homemade Half and Half Tortillas",
            description: "Fast and delicious improvised meal using homemade Half and Half Tortillas. Perfect for a quick lunch with beans, avocado, cheese, and pickled jalapenos!",
            imageName: "quick_lunch_half_half_tortillas",
            cookingTime: "00:20",
            difficulty: .low,
            hot: .one, // Добавлено: содержит pickled jalapenos
            ingredients: [
                "1/2 cup Masa Harina",
                "1/2 cup all-purpose flour",
                "1 tablespoon fat (bacon drippings recommended)",
                "1/4 teaspoon salt",
                "1/3 cup warm water (plus more to adjust consistency)",
                
                "1 cup refried beans",
                "1 avocado",
                "cheese (Queso Fresco recommended)",
                "freshly chopped cilantro",
                "pickled jalapenos",
                "lime wedges"
            ],
            steps: [
                RecipeStep(id: 1, description: "Combine Masa Harina, flour, and salt in a mixing bowl. Add fat and crumble into the mixture with your fingers."),
                RecipeStep(id: 2, description: "Pour in warm water and mix with a spoon until partially combined. Dump mixture onto work surface and knead until cohesive dough forms, adjusting with water or Masa Harina as needed."),
                RecipeStep(id: 3, description: "Portion out golfball-sized dough chunks, roll between hands, surround with plastic, and flatten with a flat-bottomed dish or rolling pin."),
                RecipeStep(id: 4, description: "Preheat skillet or comal over medium heat. Peel plastic off and cook tortillas: flip after 5–10 seconds, then cook each side 45–60 seconds until light brown spots form."),
                RecipeStep(id: 5, description: "Repeat with remaining dough. Yield: 5–7 tortillas."),
                RecipeStep(id: 6, description: "Prepare toppings: dice avocado and toss with lime and salt, chop cilantro, crumble Queso Fresco, slice lime, and prep pickled jalapenos."),
                RecipeStep(id: 7, description: "Optionally reheat tortillas with a bit of bacon fat, then spread a thin layer of refried beans."),
                RecipeStep(id: 8, description: "Assemble tortillas: add beans, pickled jalapenos, diced avocado, cheese, cilantro, and finish with lime juice. Serve immediately."),
                RecipeStep(id: 9, description: "Store leftover dough in the fridge to make fresh tortillas anytime.")
            ]
        ),
        
        Recipe(
            category: .tortillas,
            title: "Corn Tortillas Made From Popcorn Kernels",
            description: "Unique homemade corn tortillas made from popcorn kernels. Requires Calcium Hydroxide for the masa process, resulting in a surprisingly delicious tortilla.",
            imageName: "corn_tortillas_popcorn_kernels",
            cookingTime: "00:45",
            difficulty: .medium,
            hot: .one, // Добавлено: нейтральные тортильи
            ingredients: [
                "2 cups popcorn kernels",
                "1 tablespoon Calcium Hydroxide (or Cal Mexicana)",
                "2 quarts water (for cooking kernels)",
                "1 teaspoon salt",
                "1/2 cup water (for grinding masa)",
                "Masa Harina (optional, to adjust dough consistency)"
            ],
            steps: [
                RecipeStep(id: 1, description: "Rinse popcorn kernels in cold water, removing any stones or damaged kernels."),
                RecipeStep(id: 2, description: "In a non-reactive pot, dissolve Calcium Hydroxide in 2 quarts of water. Add popcorn kernels and bring to a boil, then reduce to a simmer for ~30 minutes, stirring occasionally."),
                RecipeStep(id: 3, description: "Remove from heat, cover, and let sit overnight at room temperature (or at least 6–8 hours)."),
                RecipeStep(id: 4, description: "Drain the corn and massage under running cold water to remove skins. Repeat changing water until it runs clear."),
                RecipeStep(id: 5, description: "Add drained corn to a food processor with 1 tsp salt and 1/2 cup water. Blend thoroughly, adding water as needed. If dough sticks, add Masa Harina to adjust consistency."),
                RecipeStep(id: 6, description: "Divide dough into golfball-sized portions. Flatten each dough ball using a tortilla press or a flat-bottomed dish, lining both sides with plastic."),
                RecipeStep(id: 7, description: "Preheat a skillet or comal over medium heat. Cook tortillas: flip after 10 seconds, then cook each side 1–2 minutes until light brown spots form."),
                RecipeStep(id: 8, description: "Serve immediately or store tortillas for later use.")
            ]
        ),
        
        Recipe(
            category: .tortillas,
            title: "Sopes With Refried Beans and Cheese",
            description: "Thick, hand-shaped masa cakes topped with refried beans, cheese, and optional garnishes. Crispy edges and soft centers make them perfect for any meal.",
            imageName: "sopes_refried_beans_cheese",
            cookingTime: "00:40",
            difficulty: .medium,
            hot: .two, // Добавлено: содержит chipotles
            ingredients: [
                "2 cups masa harina",
                "1/2 teaspoon salt",
                "1.5 cups warm water",
                "oil (for shallow frying)",
                "Queso Fresco (optional)",
                "pickled jalapenos (optional)",
                "freshly chopped cilantro (optional)",
                "lime wedges (optional)",
                
                "1 can black beans (or pinto beans)",
                "1/2 onion",
                "2 garlic cloves",
                "2 chipotles in adobo",
                "1 tablespoon adobo sauce",
                "1/2 teaspoon cumin",
                "1/2 teaspoon salt",
                "freshly cracked black pepper",
                "1/2 cup stock or water"
            ],
            steps: [
                RecipeStep(id: 1, description: "Prepare the masa dough: mix masa harina and salt. Add 1 cup warm water and combine. Gradually add the remaining 1/2 cup water while kneading until a cohesive ball forms. Cover with a damp towel."),
                RecipeStep(id: 2, description: "For the refried beans: sauté chopped onion and garlic in oil until lightly browned. Add drained beans, chipotles, adobo sauce, cumin, salt, pepper, and stock. Simmer a few minutes, then blend until smooth. Taste and adjust seasoning."),
                RecipeStep(id: 3, description: "Form each sope: pinch off 3 oz. of masa dough, roll into a ball, flatten to 1/4\" thickness using a flat-bottomed dish with plastic lining."),
                RecipeStep(id: 4, description: "Preheat a skillet or comal over medium heat. Cook each sope ~2 minutes per side until light brown spots form."),
                RecipeStep(id: 5, description: "Pinch edges of cooked sopes to form a ridge for toppings."),
                RecipeStep(id: 6, description: "Optional shallow fry: heat 1–2 tbsp oil to ~360F, fry sopes 1–2 minutes until crispy."),
                RecipeStep(id: 7, description: "Top sopes with refried beans, Queso Fresco, pickled jalapenos, chopped cilantro, and a squeeze of lime. Serve immediately.")
            ]
        ),
        
        Recipe(
            category: .soups,
            title: "Easy Mexican Beans and Rice Soup",
            description: "A hearty and easy Mexican soup with beans, rice, and a flavorful tomato-chipotle base. Perfect for a quick and satisfying meal.",
            imageName: "mexican_beans_rice_soup",
            cookingTime: "00:45",
            difficulty: .low,
            hot: .two, // Добавлено: содержит chipotle
            ingredients: [
                "3 plum tomatoes",
                "1/2 onion",
                "2 garlic cloves",
                "1/3 cup uncooked white rice",
                "1 can beans (15 oz, drained and rinsed)",
                "3 cups stock",
                "1 chipotle in adobo (or jalapeno)",
                "2 teaspoons Mexican oregano",
                "pinch of cumin",
                "1/2 teaspoon salt (plus more to taste)",
                "freshly cracked black pepper",
                
                // Optional garnishes
                "squeeze of lime",
                "Queso Fresco",
                "freshly chopped cilantro"
            ],
            steps: [
                RecipeStep(id: 1, description: "Rinse and de-stem the tomatoes. Roast in the oven at 400F for about 30 minutes."),
                RecipeStep(id: 2, description: "Roughly chop 1/2 onion and peel 2 garlic cloves. Sauté them in a glug of oil over medium heat, leaving garlic cloves whole."),
                RecipeStep(id: 3, description: "Blend the roasted tomatoes with the sautéed onion and garlic and 1 chipotle in adobo (or 1/2 for milder heat). Return mixture to the soup pot and cook over medium heat for a couple minutes."),
                RecipeStep(id: 4, description: "Add 3 cups stock, 1/3 cup uncooked white rice, drained beans, 2 tsp Mexican oregano, pinch of cumin, 1/2 tsp salt, and freshly cracked black pepper. Bring to a boil, then reduce to a simmer, cover, and cook for 15 minutes or until rice is tender."),
                RecipeStep(id: 5, description: "Taste and adjust seasoning with salt and oregano as needed."),
                RecipeStep(id: 6, description: "Serve immediately with optional garnishes: squeeze of lime, Queso Fresco, and freshly chopped cilantro. Note: soup does not store well with rice; consider adding rice just before serving if making ahead.")
            ]
        ),
        
        Recipe(
            category: .soups,
            title: "Roasted Poblano Soup",
            description: "A rich and flavorful Mexican soup made with roasted poblanos, onions, and a creamy stock base. Garnishes like crema and cilantro stems elevate it.",
            imageName: "roasted_poblano_soup",
            cookingTime: "01:00",
            difficulty: .medium,
            hot: .one, // Добавлено: poblanos обычно умеренно острые
            ingredients: [
                "4-5 poblano peppers",
                "1 onion",
                "4 garlic cloves",
                "3 tablespoons butter",
                "3 tablespoons all-purpose flour",
                "4 cups stock",
                "2 teaspoons Mexican oregano (optional)",
                "pinch of cumin (optional)",
                "1/2 teaspoon salt (plus more to taste)",
                "freshly ground black pepper",
                
                "finely chopped cilantro stems",
                "Mexican Crema or heavy cream",
                "hot sauce",
                "freshly ground black pepper"
            ],
            steps: [
                RecipeStep(id: 1, description: "Rinse poblanos and roast in the oven at 400F for 25-30 minutes, flipping halfway through."),
                RecipeStep(id: 2, description: "In a saucepan over medium heat, melt 3 tablespoons butter. Roughly chop the onion and sauté for 5-7 minutes until softened. Mince garlic cloves and cook for an additional minute."),
                RecipeStep(id: 3, description: "Add 3 tablespoons flour to the onion-garlic mixture and stir well. Slowly add 4 cups stock, 2 tsp Mexican oregano (optional), pinch of cumin (optional), 1/2 tsp salt, and freshly ground black pepper. Simmer 7-8 minutes."),
                RecipeStep(id: 4, description: "Once poblanos have cooled, peel, de-stem, and de-seed them. Roughly chop and add to the saucepan."),
                RecipeStep(id: 5, description: "Cook until all ingredients reach a uniform temperature, then blend until smooth. Return to saucepan and simmer 5-10 minutes. Adjust salt to taste."),
                RecipeStep(id: 6, description: "Serve immediately with optional garnishes: crema, finely chopped cilantro stems, hot sauce, and freshly ground black pepper.")
            ]
        ),
        
        Recipe(
            category: .soups,
            title: "Easy Peruano Bean Soup",
            description: "A quick and hearty Mexican soup using Peruano beans, bacon, chipotle, and roasted tomatoes. Topped with optional Queso Fresco and cilantro.",
            imageName: "easy_peruano_bean_soup",
            cookingTime: "00:35",
            difficulty: .low,
            hot: .two, // Добавлено: содержит chipotle
            ingredients: [
                "2 cups cooked Peruano beans (Canary, Mayocoba)",
                "2 cups stock",
                "1-2 plum tomatoes",
                "2 slices bacon (optional)",
                "1/2 onion",
                "2 garlic cloves",
                "1 chipotle in adobo",
                "1/2 teaspoon cumin (optional)",
                "1 teaspoon Mexican oregano",
                "1/2 teaspoon salt (plus more to taste)",
                "freshly cracked black pepper",
                
                "Queso Fresco",
                "freshly chopped cilantro"
            ],
            steps: [
                RecipeStep(id: 1, description: "Rinse and de-stem tomatoes, then roast at 400F for 20-25 minutes."),
                RecipeStep(id: 2, description: "Chop bacon and cook over medium-high heat until browned. Remove and drain on paper towel."),
                RecipeStep(id: 3, description: "Use leftover bacon drippings to cook roughly chopped onion and garlic over medium heat until onion starts to brown."),
                RecipeStep(id: 4, description: "Add 1 tsp Mexican oregano, 1/2 tsp cumin (optional), 1/2 tsp salt, and freshly cracked black pepper to the aromatics. Stir briefly."),
                RecipeStep(id: 5, description: "Add remaining ingredients: Peruano beans, stock, chipotle in adobo, roasted tomatoes, and cooked bacon pieces. Bring to medium heat."),
                RecipeStep(id: 6, description: "Blend the mixture carefully until smooth. Return to pot and simmer for final taste adjustments. Adjust thickness by simmering uncovered or adding stock."),
                RecipeStep(id: 7, description: "Serve hot, optionally topped with reserved bacon pieces, Queso Fresco, and freshly chopped cilantro.")
            ]
        ),
        
        Recipe(
            category: .soups,
            title: "Chili con Carne",
            description: "An authentic Mexican Chili con Carne using dried chiles, beef chuck roast, beans, and roasted tomatoes. Rich, hearty, and flavorful.",
            imageName: "chili_con_carne",
            cookingTime: "02:30",
            difficulty: .hard,
            hot: .three, // Добавлено: содержит много острых перцев
            ingredients: [
                "2-2.5 lbs. chuck roast",
                "3 Ancho dried chiles",
                "3 Guajillo dried chiles",
                "1 onion",
                "4 garlic cloves",
                "3-4 Roma tomatoes",
                "1 chipotle in adobo (optional)",
                "1-2 cans beans (15oz each, black beans)",
                "5 cups stock",
                "1 tablespoon Mexican oregano",
                "1/2 teaspoon cumin",
                "1 teaspoon salt (plus more to taste)",
                "freshly cracked black pepper",
                
                // Optional garnishes
                "Mexican Crema",
                "freshly chopped cilantro",
                "crispy tortilla strips",
                "lime wedges"
            ],
            steps: [
                RecipeStep(id: 1, description: "De-stem and de-seed dried chiles. Roast in oven 1-2 minutes until fragrant. Soak in hot water for 20 minutes."),
                RecipeStep(id: 2, description: "Rinse and de-stem tomatoes. Roast at 400F for 20-30 minutes."),
                RecipeStep(id: 3, description: "Preheat pot with oil. Chop chuck roast into 1-1.5\" chunks, season with salt, sear until browned. Set aside."),
                RecipeStep(id: 4, description: "Cook finely chopped onion in the same pot until softened. Add minced garlic, cook briefly. Scoop half for chile puree."),
                RecipeStep(id: 5, description: "In blender, combine drained chiles, 1 roasted tomato, chipotle (optional), half of onion-garlic mix, and 1 cup stock. Blend until smooth."),
                RecipeStep(id: 6, description: "Add chile puree to main pot along with oregano, cumin, salt, pepper, remaining stock. Stir and add seared beef and remaining roasted tomatoes."),
                RecipeStep(id: 7, description: "Simmer covered for 1.5-2 hours or until beef is tender."),
                RecipeStep(id: 8, description: "Add drained beans in the last 10 minutes if using."),
                RecipeStep(id: 9, description: "Adjust consistency: add stock to thin or cornstarch slurry to thicken."),
                RecipeStep(id: 10, description: "Taste and adjust seasoning. Serve hot with optional garnishes: Crema, cilantro, tortilla strips, lime wedges.")
            ]
        )
    ]
}

        
