//
//  TInsulinDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TInsulinDatumTests: XCTestCase {
    static let insulin = TInsulinDatum(time: Date.test,
                                       dose: TInsulinDatumDoseTests.dose,
                                       formulation: TInsulinDatumFormulationTests.formulation,
                                       site: "Area 51")
    static let insulinJSONDictionary: [String: Any] = [
        "type": "insulin",
        "time": Date.testJSONString,
        "dose": TInsulinDatumDoseTests.doseJSONDictionary,
        "formulation": TInsulinDatumFormulationTests.formulationJSONDictionary,
        "site": "Area 51"
    ]
    
    func testInitializer() {
        let insulin = TInsulinDatumTests.insulin
        XCTAssertEqual(insulin.dose, TInsulinDatumDoseTests.dose)
        XCTAssertEqual(insulin.formulation, TInsulinDatumFormulationTests.formulation)
        XCTAssertEqual(insulin.site, "Area 51")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TInsulinDatumTests.insulin, TInsulinDatumTests.insulinJSONDictionary)
    }
}

class TInsulinDatumDoseTests: XCTestCase {
    static let dose = TInsulinDatum.Dose(active: 1.23, correction: 2.34, food: 3.45, total: 4.56, units: .units)
    static let doseJSONDictionary: [String: Any] = [
        "active": 1.23,
        "correction": 2.34,
        "food": 3.45,
        "total": 4.56,
        "units": "Units"
    ]
    
    func testInitializer() {
        let dose = TInsulinDatumDoseTests.dose
        XCTAssertEqual(dose.active, 1.23)
        XCTAssertEqual(dose.correction, 2.34)
        XCTAssertEqual(dose.food, 3.45)
        XCTAssertEqual(dose.total, 4.56)
        XCTAssertEqual(dose.units, .units)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TInsulinDatumDoseTests.dose, TInsulinDatumDoseTests.doseJSONDictionary)
    }
}

class TInsulinDatumFormulationTests: XCTestCase {
    static let formulation = TInsulinDatum.Formulation(name: "Mystery Mix",
                                                       simple: TInsulinDatumFormulationSimpleTests.simple,
                                                       compounds: [TInsulinDatumFormulationCompoundTests.compound, TInsulinDatumFormulationCompoundTests.compound])
    static let formulationJSONDictionary: [String: Any] = [
        "name": "Mystery Mix",
        "simple": TInsulinDatumFormulationSimpleTests.simpleJSONDictionary,
        "compounds": [TInsulinDatumFormulationCompoundTests.compoundJSONDictionary, TInsulinDatumFormulationCompoundTests.compoundJSONDictionary]
    ]
    
    func testInitializer() {
        let formulation = TInsulinDatumFormulationTests.formulation
        XCTAssertEqual(formulation.name, "Mystery Mix")
        XCTAssertEqual(formulation.simple, TInsulinDatumFormulationSimpleTests.simple)
        XCTAssertEqual(formulation.compounds, [TInsulinDatumFormulationCompoundTests.compound, TInsulinDatumFormulationCompoundTests.compound])
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TInsulinDatumFormulationTests.formulation, TInsulinDatumFormulationTests.formulationJSONDictionary)
    }
}

class TInsulinDatumFormulationSimpleTests: XCTestCase {
    static let simple = TInsulinDatum.Formulation.Simple(actingType: .rapid, brand: "Humalog", concentration: TInsulinDatumFormulationSimpleConcentrationTests.concentration)
    static let simpleJSONDictionary: [String: Any] = [
        "actingType": "rapid",
        "brand": "Humalog",
        "concentration": TInsulinDatumFormulationSimpleConcentrationTests.concentrationJSONDictionary
    ]
    
    func testInitializer() {
        let simple = TInsulinDatumFormulationSimpleTests.simple
        XCTAssertEqual(simple.actingType, .rapid)
        XCTAssertEqual(simple.brand, "Humalog")
        XCTAssertEqual(simple.concentration, TInsulinDatumFormulationSimpleConcentrationTests.concentration)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TInsulinDatumFormulationSimpleTests.simple, TInsulinDatumFormulationSimpleTests.simpleJSONDictionary)
    }
}

class TInsulinDatumFormulationSimpleActingTypeTests: XCTestCase {
    func testActingType() {
        XCTAssertEqual(TInsulinDatum.Formulation.Simple.ActingType.rapid.rawValue, "rapid")
        XCTAssertEqual(TInsulinDatum.Formulation.Simple.ActingType.short.rawValue, "short")
        XCTAssertEqual(TInsulinDatum.Formulation.Simple.ActingType.intermediate.rawValue, "intermediate")
        XCTAssertEqual(TInsulinDatum.Formulation.Simple.ActingType.long.rawValue, "long")
    }
}

class TInsulinDatumFormulationSimpleConcentrationTests: XCTestCase {
    static let concentration = TInsulinDatum.Formulation.Simple.Concentration(1.23, .unitsPerML)
    static let concentrationJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "Units/mL"
    ]
    
    func testInitializer() {
        let concentration = TInsulinDatumFormulationSimpleConcentrationTests.concentration
        XCTAssertEqual(concentration.value, 1.23)
        XCTAssertEqual(concentration.units, .unitsPerML)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TInsulinDatumFormulationSimpleConcentrationTests.concentration, TInsulinDatumFormulationSimpleConcentrationTests.concentrationJSONDictionary)
    }
}

class TInsulinDatumFormulationSimpleConcentrationUnitsTests: XCTestCase {
    func testInitializer() {
        XCTAssertEqual(TInsulinDatum.Formulation.Simple.Concentration.Units.unitsPerML.rawValue, "Units/mL")
    }
}

class TInsulinDatumFormulationCompoundTests: XCTestCase {
    static let compound = TInsulinDatum.Formulation.Compound(amount: 1.23, formulation: TInsulinDatum.Formulation(name: "Formula X"))
    static let compoundJSONDictionary: [String: Any] = [
        "amount": 1.23,
        "formulation": [
            "name": "Formula X"
        ]
    ]
    
    func testInitializer() {
        let compound = TInsulinDatumFormulationCompoundTests.compound
        XCTAssertEqual(compound.amount, 1.23)
        XCTAssertEqual(compound.formulation, TInsulinDatum.Formulation(name: "Formula X"))
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TInsulinDatumFormulationCompoundTests.compound, TInsulinDatumFormulationCompoundTests.compoundJSONDictionary)
    }
}

extension TInsulinDatum {
    func isEqual(to other: TInsulinDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.dose == other.dose &&
            self.formulation == other.formulation &&
            self.site == other.site
    }
}
