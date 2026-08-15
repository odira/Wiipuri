import Foundation
import SwiftUI
import CoreLocation


public struct Unit: Hashable, Codable, Identifiable {
    
    public var id: Int            //  0
    public var parentId: Int?     //  1
    public var typeId: Int?       //  2
    public var type: String?      //  3
    public var abbr: String?      //  4
    public var unit: String?      //  5
    public var cityId: Int?       //  6
    public var city: String?      //  7
    public var adId: Int?         //  8
    public var ad: String?        //  9
    public var icao: String?      // 10
    public var note: String?      // 11
    
    // MARK: - Initializations
    
    public init(
        id: Int,                  //  0
        parentId: Int,            //  1
        typeId: Int? = nil,       //  2
        type: String? = nil,      //  3
        abbr: String? = nil,      //  4
        unit: String? = nil,      //  5
        cityId: Int? = nil,       //  6
        city: String? = nil,      //  7
        adId: Int? = nil,         //  8
        ad: String? = nil,        //  9
        icao: String? = nil,      // 10
        note: String? = nil       // 11
    ) {
        self.id = id              //  0
        self.parentId = parentId  //  1
        self.typeId = typeId      //  2
        self.type = type          //  3
        self.abbr = abbr          //  4
        self.unit = unit          //  5
        self.cityId = cityId      //  6
        self.city = city          //  7
        self.adId = adId          //  8
        self.ad = ad              //  9
        self.icao = icao          // 10
        self.note = note          // 11
    }
}


// MARK: - Unit example

#if DEBUG
public extension Unit {
    
    static let example = samples[0]
    static let samples: [Unit] = [
        Unit(id: 100,                   //  0
             parentId: 1,               //  1
             typeId: 3,                 //  2
             type: "Отделение",         //  3
             abbr: "КДП",               //  4
             unit: "КДП Новые Васюки",  //  5
             cityId: 1234,              //  6
             city: "Москва",            //  7
             adId: 1234,                //  8
             ad: "Васюки",              //  9
             icao: "UUUU",              // 10
             note: "TEST Note"          // 11
        )
    ]
    
}
#endif
