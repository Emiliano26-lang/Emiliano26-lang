import Foundation

class SampleData {
    static let recipes: [Recipe] = [
        Recipe(
            name: "Spaghetti Carbonara",
            cuisine: .italian,
            cookingTime: 30,
            difficulty: .medium,
            dietaryRestrictions: [.vegetarian],
            ingredients: ["Spaghetti", "Eggs", "Parmesan cheese", "Pancetta", "Black pepper"],
            rating: 4.8,
            servings: 4,
            description: "Classic Italian pasta dish with eggs, cheese, and pancetta.",
            imageURL: nil
        ),
        Recipe(
            name: "Chicken Tikka Masala",
            cuisine: .indian,
            cookingTime: 45,
            difficulty: .medium,
            dietaryRestrictions: [.glutenFree],
            ingredients: ["Chicken", "Yogurt", "Tomatoes", "Cream", "Spices"],
            rating: 4.6,
            servings: 6,
            description: "Creamy and flavorful Indian curry with tender chicken.",
            imageURL: nil
        ),
        Recipe(
            name: "Vegetable Stir Fry",
            cuisine: .chinese,
            cookingTime: 15,
            difficulty: .easy,
            dietaryRestrictions: [.vegetarian, .vegan, .glutenFree],
            ingredients: ["Mixed vegetables", "Soy sauce", "Garlic", "Ginger", "Sesame oil"],
            rating: 4.2,
            servings: 3,
            description: "Quick and healthy vegetable stir fry with Asian flavors.",
            imageURL: nil
        ),
        Recipe(
            name: "Beef Tacos",
            cuisine: .mexican,
            cookingTime: 25,
            difficulty: .easy,
            dietaryRestrictions: [.glutenFree],
            ingredients: ["Ground beef", "Taco shells", "Cheese", "Lettuce", "Tomatoes"],
            rating: 4.5,
            servings: 4,
            description: "Delicious and easy beef tacos with fresh toppings.",
            imageURL: nil
        ),
        Recipe(
            name: "Caesar Salad",
            cuisine: .american,
            cookingTime: 10,
            difficulty: .easy,
            dietaryRestrictions: [.vegetarian],
            ingredients: ["Romaine lettuce", "Parmesan cheese", "Croutons", "Caesar dressing"],
            rating: 4.0,
            servings: 2,
            description: "Fresh and crispy Caesar salad with homemade dressing.",
            imageURL: nil
        ),
        Recipe(
            name: "Ratatouille",
            cuisine: .french,
            cookingTime: 60,
            difficulty: .medium,
            dietaryRestrictions: [.vegetarian, .vegan, .glutenFree],
            ingredients: ["Eggplant", "Zucchini", "Tomatoes", "Bell peppers", "Herbs"],
            rating: 4.3,
            servings: 6,
            description: "Traditional French vegetable stew with Mediterranean flavors.",
            imageURL: nil
        ),
        Recipe(
            name: "Salmon Teriyaki",
            cuisine: .japanese,
            cookingTime: 20,
            difficulty: .medium,
            dietaryRestrictions: [.glutenFree, .dairyFree],
            ingredients: ["Salmon", "Teriyaki sauce", "Rice", "Broccoli", "Sesame seeds"],
            rating: 4.7,
            servings: 2,
            description: "Glazed salmon with teriyaki sauce served over rice.",
            imageURL: nil
        ),
        Recipe(
            name: "Pad Thai",
            cuisine: .thai,
            cookingTime: 35,
            difficulty: .hard,
            dietaryRestrictions: [.glutenFree],
            ingredients: ["Rice noodles", "Shrimp", "Bean sprouts", "Peanuts", "Lime"],
            rating: 4.4,
            servings: 4,
            description: "Authentic Thai stir-fried noodles with shrimp and vegetables.",
            imageURL: nil
        ),
        Recipe(
            name: "Greek Salad",
            cuisine: .mediterranean,
            cookingTime: 15,
            difficulty: .easy,
            dietaryRestrictions: [.vegetarian, .glutenFree],
            ingredients: ["Tomatoes", "Cucumber", "Feta cheese", "Olives", "Olive oil"],
            rating: 4.1,
            servings: 4,
            description: "Fresh Mediterranean salad with feta cheese and olives.",
            imageURL: nil
        ),
        Recipe(
            name: "Bibimbap",
            cuisine: .korean,
            cookingTime: 40,
            difficulty: .medium,
            dietaryRestrictions: [.glutenFree],
            ingredients: ["Rice", "Mixed vegetables", "Beef", "Egg", "Gochujang"],
            rating: 4.6,
            servings: 2,
            description: "Korean rice bowl with seasoned vegetables and meat.",
            imageURL: nil
        )
    ]
}