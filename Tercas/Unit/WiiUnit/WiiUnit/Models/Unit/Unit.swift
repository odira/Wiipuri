import Foundation
import SwiftUI
import CoreLocation


public struct Unit: Hashable, Codable, Identifiable {
    
    // MARK: - Main parameters
    
    public var id: Int                //  0
    public var parentId: Int          //  1
    public var typeId: Int?           //  2
    public var typeAbbr: String?      //  3
    public var type: String           //  4
    public var typeNote: String?      //  5
    public var abbr: String?          //  6
    public var unit: String           //  7
    public var adId: Int?             //  8
    public var cityId: Int?           //  9
    public var city: String?          // 10
    public var ops: Bool?             // 11
    public var note: String?          // 12
    
    // MARK: - Composed parameters

    
    // MARK: - Initializations
    
    public init(
        id: Int,                       //  0
        parentId: Int,                 //  1
        typeId: Int? = nil,            //  2
        typeAbbr: String? = nil,       //  3
        type: String,                  //  4
        typeNote: String?,             //  5
        abbr: String? = nil,           //  6
        unit: String,                  //  7
        adId: Int? = nil,              //  8
        cityId: Int? = nil,            //  9
        city: String? = nil,           // 10
        ops: Bool,                     // 11
        note: String? = nil            // 12
    ) {
        self.id = id                   //  0
        self.parentId = parentId       //  1
        self.typeId = typeId           //  2
        self.typeAbbr = typeAbbr       //  3
        self.type = type               //  4
        self.typeNote = typeNote       //  5
        self.abbr = abbr               //  6
        self.unit = unit               //  7
        self.adId = adId               //  8
        self.cityId = cityId           //  9
        self.city = city               // 10
        self.ops = ops                 // 11
        self.note = note               // 12
    }
}


// MARK: - Unit example

#if DEBUG
public extension Unit {
    
    static let example = samples[0]
    static let samples: [Unit] = [
        Unit(id: 100,                  //  0
             parentId: 1,              //  1
             typeId: 3,                //  2
             typeAbbr: "КДП",          //  3
             type: "Отделение",        //  4
             typeNote: "TEST note",    //  5
             abbr: "КДП",              //  6
             unit: "КДП Новые Васюки", //  7
             adId: 1234,               //  8
             cityId: 1234,             //  9
             city: "Москва",           // 10
             ops: true,                // 11
             note: "TEST Note"         // 12
        )
    ]
    
}
#endif
