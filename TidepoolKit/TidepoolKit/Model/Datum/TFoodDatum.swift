//
//  TFoodDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/23/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TFoodDatum: TDatum, Decodable {
    public enum Meal: String, Codable {
        case breakfast
        case lunch
        case dinner
        case snack
        case other
    }

    public var name: String?
    public var amount: Amount?
    public var brand: String?
    public var code: String?
    public var meal: Meal?
    public var mealOther: String?
    public var nutrition: Nutrition?
    public var ingredients: [Ingredient]?

    public init(time: Date, name: String? = nil, amount: Amount? = nil, brand: String? = nil, code: String? = nil, meal: Meal? = nil, mealOther: String? = nil, nutrition: Nutrition? = nil, ingredients: [Ingredient]? = nil) {
        self.name = name
        self.amount = amount
        self.brand = brand
        self.code = code
        self.meal = meal
        self.mealOther = mealOther
        self.nutrition = nutrition
        self.ingredients = ingredients
        super.init(.food, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.amount = try container.decodeIfPresent(Amount.self, forKey: .amount)
        self.brand = try container.decodeIfPresent(String.self, forKey: .brand)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.meal = try container.decodeIfPresent(Meal.self, forKey: .meal)
        self.mealOther = try container.decodeIfPresent(String.self, forKey: .mealOther)
        self.nutrition = try container.decodeIfPresent(Nutrition.self, forKey: .nutrition)
        self.ingredients = try container.decodeIfPresent([Ingredient].self, forKey: .ingredients)
        try super.init(.food, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(brand, forKey: .brand)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(meal, forKey: .meal)
        try container.encodeIfPresent(mealOther, forKey: .mealOther)
        try container.encodeIfPresent(nutrition, forKey: .nutrition)
        try container.encodeIfPresent(ingredients, forKey: .ingredients)
        try super.encode(to: encoder)
    }

    public struct Amount: Codable, Equatable {
        public var value: Double?
        public var units: String?

        public init(_ value: Double, _ units: String) {
            self.value = value
            self.units = units
        }
    }

    public struct Nutrition: Codable, Equatable {
        public var carbohydrate: Carbohydrate?
        public var fat: Fat?
        public var protein: Protein?
        public var energy: Energy?
        public var estimatedAbsorptionDuration: TimeInterval?

        public init(carbohydrate: Carbohydrate? = nil, fat: Fat? = nil, protein: Protein? = nil, energy: Energy? = nil, estimatedAbsorptionDuration: TimeInterval? = nil) {
            self.carbohydrate = carbohydrate
            self.fat = fat
            self.protein = protein
            self.energy = energy
            self.estimatedAbsorptionDuration = estimatedAbsorptionDuration
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.carbohydrate = try container.decodeIfPresent(Carbohydrate.self, forKey: .carbohydrate)
            self.fat = try container.decodeIfPresent(Fat.self, forKey: .fat)
            self.protein = try container.decodeIfPresent(Protein.self, forKey: .protein)
            self.energy = try container.decodeIfPresent(Energy.self, forKey: .energy)
            self.estimatedAbsorptionDuration = try container.decodeIfPresent(Int.self, forKey: .estimatedAbsorptionDuration).map { .seconds($0) }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(carbohydrate, forKey: .carbohydrate)
            try container.encodeIfPresent(fat, forKey: .fat)
            try container.encodeIfPresent(protein, forKey: .protein)
            try container.encodeIfPresent(energy, forKey: .energy)
            try container.encodeIfPresent(estimatedAbsorptionDuration.map { Int($0.seconds) }, forKey: .estimatedAbsorptionDuration)
        }

        public struct Carbohydrate: Codable, Equatable {
            public typealias Units = TCarbohydrate.Units

            public var net: Double?
            public var sugars: Double?
            public var dietaryFiber: Double?
            public var total: Double?
            public var units: Units?

            public init(net: Double? = nil, sugars: Double? = nil, dietaryFiber: Double? = nil, total: Double? = nil, units: Units? = .grams) {
                self.net = net
                self.sugars = sugars
                self.dietaryFiber = dietaryFiber
                self.total = total
                self.units = units
            }
        }

        public struct Fat: Codable, Equatable {
            public enum Units: String, Codable {
                case grams
            }

            public var total: Double?
            public var units: Units?

            public init(_ total: Double, _ units: Units? = .grams) {
                self.total = total
                self.units = units
            }
        }

        public struct Protein: Codable, Equatable {
            public enum Units: String, Codable {
                case grams
            }

            public var total: Double?
            public var units: Units?

            public init(_ total: Double, _ units: Units? = .grams) {
                self.total = total
                self.units = units
            }
        }

        public struct Energy: Codable, Equatable {
            public enum Units: String, Codable {
                case calories
                case joules
                case kilocalories
                case kilojoules
            }

            public var value: Double?
            public var units: Units?

            public init(_ value: Double, _ units: Units) {
                self.value = value
                self.units = units
            }
        }

        private enum CodingKeys: String, CodingKey {
            case carbohydrate
            case fat
            case protein
            case energy
            case estimatedAbsorptionDuration
        }
    }

    public struct Ingredient: Codable, Equatable {
        public var name: String?
        public var amount: Amount?
        public var brand: String?
        public var code: String?
        public var nutrition: Nutrition?
        public var ingredients: [Ingredient]?

        public init(name: String? = nil, amount: Amount? = nil, brand: String? = nil, code: String? = nil, nutrition: Nutrition? = nil, ingredients: [Ingredient]? = nil) {
            self.name = name
            self.amount = amount
            self.brand = brand
            self.code = code
            self.nutrition = nutrition
            self.ingredients = ingredients
        }
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case amount
        case brand
        case code
        case meal
        case mealOther
        case nutrition
        case ingredients
    }
}
