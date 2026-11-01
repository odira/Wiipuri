//
//  Unit.swift
//  WiiEvent
//
//  Created by Wiipuri Developer on 01.11.2026.
//

import SwiftUI


public struct Unit: Hashable, Codable, Identifiable {
    
    public var id: Int          // 0
    public var unit: String     // 1
    public var city_id: Int     // 2
    public var city: String     // 3
    public var ad: String?      // 4
    public var ICAO: String?    // 5
    
    public init(
        id: Int,                // 0
        unit: String,           // 1
        city_id: Int,           // 2
        city: String,           // 3
        ad: String?,            // 4
        ICAO: String?           // 5
    ) {
        self.id = id            // 0
        self.unit = unit        // 1
        self.city_id = city_id  // 2
        self.city = city        // 3
        self.ad = ad            // 4
        self.ICAO = ICAO        // 5
    }
}

// MARK: - UnitShot example

#if DEBUG
public extension Unit {
    static let example = samples[0]
    static let samples: [Unit] = [
        Unit(
            id: -1000,
            unit: "Выборгский ЦОВД",
            city_id: 10,
            city: "Выборг",
            ad: "Lapeenranta",
            ICAO: "WBRG"
        )
    ]
}
#endif
