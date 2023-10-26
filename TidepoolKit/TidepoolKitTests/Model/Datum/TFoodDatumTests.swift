//
//  TFoodDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/7/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TFoodDatumTests: XCTestCase {
    static let food = TFoodDatum(time: Date.test,
                                 name: "Amazing",
                                 amount: TFoodDatumAmountTests.amount,
                                 brand: "Foodie",
                                 code: "XYZ",
                                 meal: .other,
                                 mealOther: "midnightSnack",
                                 nutrition: TFoodDatumNutritionTests.nutrition,
                                 ingredients: [TFoodDatumIngredientTests.ingredient])
    static let foodJSONDictionary: [String: Any] = [
        "type": "food",
        "time": Date.testJSONString,
        "name": "Amazing",
        "amount": TFoodDatumAmountTests.amountJSONDictionary,
        "brand": "Foodie",
        "code": "XYZ",
        "meal": "other",
        "mealOther": "midnightSnack",
        "nutrition": TFoodDatumNutritionTests.nutritionJSONDictionary,
        "ingredients": [TFoodDatumIngredientTests.ingredientJSONDictionary]
    ]
    
    func testInitializer() {
        let food = TFoodDatumTests.food
        XCTAssertEqual(food.name, "Amazing")
        XCTAssertEqual(food.amount, TFoodDatumAmountTests.amount)
        XCTAssertEqual(food.brand, "Foodie")
        XCTAssertEqual(food.code, "XYZ")
        XCTAssertEqual(food.meal, .other)
        XCTAssertEqual(food.mealOther, "midnightSnack")
        XCTAssertEqual(food.nutrition, TFoodDatumNutritionTests.nutrition)
        XCTAssertEqual(food.ingredients, [TFoodDatumIngredientTests.ingredient])
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumTests.food, TFoodDatumTests.foodJSONDictionary)
    }
}

class TFoodDatumMealTests: XCTestCase {
    func testMeal() {
        XCTAssertEqual(TFoodDatum.Meal.breakfast.rawValue, "breakfast")
        XCTAssertEqual(TFoodDatum.Meal.lunch.rawValue, "lunch")
        XCTAssertEqual(TFoodDatum.Meal.dinner.rawValue, "dinner")
        XCTAssertEqual(TFoodDatum.Meal.snack.rawValue, "snack")
        XCTAssertEqual(TFoodDatum.Meal.other.rawValue, "other")
    }
}

class TFoodDatumAmountTests: XCTestCase {
    static let amount = TFoodDatum.Amount(1.23, "cups")
    static let amountJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "cups"
    ]
    
    func testInitializer() {
        let amount = TFoodDatumAmountTests.amount
        XCTAssertEqual(amount.value, 1.23)
        XCTAssertEqual(amount.units, "cups")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumAmountTests.amount, TFoodDatumAmountTests.amountJSONDictionary)
    }
}

class TFoodDatumNutritionTests: XCTestCase {
    static let nutrition = TFoodDatum.Nutrition(carbohydrate: TFoodDatumNutritionCarbohydrateTests.carbohydrate,
                                                fat: TFoodDatumNutritionFatTests.fat,
                                                protein: TFoodDatumNutritionProteinTests.protein,
                                                energy: TFoodDatumNutritionEnergyTests.energy,
                                                estimatedAbsorptionDuration: 12345)
    static let nutritionJSONDictionary: [String: Any] = [
        "carbohydrate": TFoodDatumNutritionCarbohydrateTests.carbohydrateJSONDictionary,
        "fat": TFoodDatumNutritionFatTests.fatJSONDictionary,
        "protein": TFoodDatumNutritionProteinTests.proteinJSONDictionary,
        "energy": TFoodDatumNutritionEnergyTests.energyJSONDictionary,
        "estimatedAbsorptionDuration": 12345
    ]
    
    func testInitializer() {
        let nutrition = TFoodDatumNutritionTests.nutrition
        XCTAssertEqual(nutrition.carbohydrate, TFoodDatumNutritionCarbohydrateTests.carbohydrate)
        XCTAssertEqual(nutrition.fat, TFoodDatumNutritionFatTests.fat)
        XCTAssertEqual(nutrition.protein, TFoodDatumNutritionProteinTests.protein)
        XCTAssertEqual(nutrition.energy, TFoodDatumNutritionEnergyTests.energy)
        XCTAssertEqual(nutrition.estimatedAbsorptionDuration, 12345)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumNutritionTests.nutrition, TFoodDatumNutritionTests.nutritionJSONDictionary)
    }
}

class TFoodDatumNutritionCarbohydrateTests: XCTestCase {
    static let carbohydrate = TFoodDatum.Nutrition.Carbohydrate(net: 1.23, sugars: 2.34, dietaryFiber: 3.45, total: 4.56, units: .grams)
    static let carbohydrateJSONDictionary: [String: Any] = [
        "net": 1.23,
        "sugars": 2.34,
        "dietaryFiber": 3.45,
        "total": 4.56,
        "units": "grams"
    ]
    
    func testInitializer() {
        let carbohydrate = TFoodDatumNutritionCarbohydrateTests.carbohydrate
        XCTAssertEqual(carbohydrate.net, 1.23)
        XCTAssertEqual(carbohydrate.sugars, 2.34)
        XCTAssertEqual(carbohydrate.dietaryFiber, 3.45)
        XCTAssertEqual(carbohydrate.total, 4.56)
        XCTAssertEqual(carbohydrate.units, .grams)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumNutritionCarbohydrateTests.carbohydrate, TFoodDatumNutritionCarbohydrateTests.carbohydrateJSONDictionary)
    }
}

class TFoodDatumNutritionCarbohydrateUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TFoodDatum.Nutrition.Carbohydrate.Units.grams.rawValue, "grams")
    }
}

class TFoodDatumNutritionFatTests: XCTestCase {
    static let fat = TFoodDatum.Nutrition.Fat(1.23, .grams)
    static let fatJSONDictionary: [String: Any] = [
        "total": 1.23,
        "units": "grams"
    ]
    
    func testInitializer() {
        let fat = TFoodDatumNutritionFatTests.fat
        XCTAssertEqual(fat.total, 1.23)
        XCTAssertEqual(fat.units, .grams)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumNutritionFatTests.fat, TFoodDatumNutritionFatTests.fatJSONDictionary)
    }
}

class TFoodDatumNutritionFatUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TFoodDatum.Nutrition.Fat.Units.grams.rawValue, "grams")
    }
}

class TFoodDatumNutritionProteinTests: XCTestCase {
    static let protein = TFoodDatum.Nutrition.Protein(1.23, .grams)
    static let proteinJSONDictionary: [String: Any] = [
        "total": 1.23,
        "units": "grams"
    ]
    
    func testInitializer() {
        let protein = TFoodDatumNutritionProteinTests.protein
        XCTAssertEqual(protein.total, 1.23)
        XCTAssertEqual(protein.units, .grams)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumNutritionProteinTests.protein, TFoodDatumNutritionProteinTests.proteinJSONDictionary)
    }
}

class TFoodDatumNutritionProteinUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TFoodDatum.Nutrition.Protein.Units.grams.rawValue, "grams")
    }
}

class TFoodDatumNutritionEnergyTests: XCTestCase {
    static let energy = TFoodDatum.Nutrition.Energy(1.23, .kilocalories)
    static let energyJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "kilocalories"
    ]
    
    func testInitializer() {
        let energy = TFoodDatumNutritionEnergyTests.energy
        XCTAssertEqual(energy.value, 1.23)
        XCTAssertEqual(energy.units, .kilocalories)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumNutritionEnergyTests.energy, TFoodDatumNutritionEnergyTests.energyJSONDictionary)
    }
}

class TFoodDatumNutritionEnergyUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TFoodDatum.Nutrition.Energy.Units.calories.rawValue, "calories")
        XCTAssertEqual(TFoodDatum.Nutrition.Energy.Units.joules.rawValue, "joules")
        XCTAssertEqual(TFoodDatum.Nutrition.Energy.Units.kilocalories.rawValue, "kilocalories")
        XCTAssertEqual(TFoodDatum.Nutrition.Energy.Units.kilojoules.rawValue, "kilojoules")
    }
}

class TFoodDatumIngredientTests: XCTestCase {
    static let ingredient = TFoodDatum.Ingredient(name: "Stuff",
                                                  amount: TFoodDatumAmountTests.amount,
                                                  brand: "Acme",
                                                  code: "ABCDEF",
                                                  nutrition: TFoodDatumNutritionTests.nutrition,
                                                  ingredients: [TFoodDatum.Ingredient(name: "Other")])
    static let ingredientJSONDictionary: [String: Any] = [
        "name": "Stuff",
        "amount": TFoodDatumAmountTests.amountJSONDictionary,
        "brand": "Acme",
        "code": "ABCDEF",
        "nutrition": TFoodDatumNutritionTests.nutritionJSONDictionary,
        "ingredients": [["name": "Other"]]
    ]
    
    func testInitializer() {
        let ingredient = TFoodDatumIngredientTests.ingredient
        XCTAssertEqual(ingredient.name, "Stuff")
        XCTAssertEqual(ingredient.amount, TFoodDatumAmountTests.amount)
        XCTAssertEqual(ingredient.brand, "Acme")
        XCTAssertEqual(ingredient.code, "ABCDEF")
        XCTAssertEqual(ingredient.nutrition, TFoodDatumNutritionTests.nutrition)
        XCTAssertEqual(ingredient.ingredients, [TFoodDatum.Ingredient(name: "Other")])
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TFoodDatumIngredientTests.ingredient, TFoodDatumIngredientTests.ingredientJSONDictionary)
    }
}

extension TFoodDatum {
    func isEqual(to other: TFoodDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.name == other.name &&
            self.amount == other.amount &&
            self.brand == other.brand &&
            self.code == other.code &&
            self.meal == other.meal &&
            self.mealOther == other.mealOther &&
            self.nutrition == other.nutrition &&
            self.ingredients == other.ingredients
    }
}
