//
//  UnitModel.swift
//  WiiEvent
//
//  Created by Wiipuri Developer on 01.11.2026.
//

import PostgresClientKit
import SwiftUI
import Combine


class UnitModel: ObservableObject {
    @Published public var units = [Unit]()
    @Published public var isFetching: Bool = true
    
    public init(units: [Unit]) {
        self.units = units
    }
   
    public init() {
        self.units = []
    }
    
    deinit {
        self.units.removeAll()
    }
   
    public func reload() async {
        self.units.removeAll()
        await fetch()
    }
    
    @MainActor
    public func fetch() async {
        isFetching = true
        
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "217.107.219.91"
            configuration.database = "unit"
            configuration.user = "postgres"
            configuration.credential = .trust // .scramSHA256(password: "monrepo")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            
            let sqlText = """
                SELECT 
                    id,       -- 0
                    unit,     -- 1
                    city_id,  -- 2
                    city,     -- 3
                    ad,       -- 4
                    ICAO      -- 5
                FROM 
                    unit.vw_unit
            """
            let statement = try connection.prepareStatement(text: sqlText)
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
        
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()        /// 0
                let unit = try columns[1].string()   /// 1
                let city_id = try columns[2].int()   /// 2
                let city = try columns[3].string()   /// 3
                let ad = try? columns[4].string()    /// 4
                let ICAO = try? columns[5].string()  /// 5
                
                units.append(
                    Unit(
                        id: id,            /// 0
                        unit: unit,        /// 1
                        city_id: city_id,  /// 2
                        city: city,        /// 3
                        ad: ad,            /// 4
                        ICAO: ICAO         /// 5
                    )
                )
            }
            
        } catch {
            print(error)
        }
        
        isFetching = false
    }
}

// MARK: - UnitModel example

#if DEBUG
extension UnitModel {
   
    public static let unitsExmpls: [Unit] = [
        Unit.example,
        Unit.example,
        Unit.example,
        Unit.example
   ]
   
   public static let example = samples[0]
   public static let samples: [UnitModel] = [
        UnitModel(units: unitsExmpls)
   ]
   
}
#endif


// MARK: - Additional Functions (get & search)

extension UnitModel {
    
//    public func findUnits(byEventID eventID: Int) -> [Info]? {
//        let result = infos.filter { $0.eventID == eventID }
//        if result.isEmpty {
//            return nil
//        }
//        return result
//    }
    
//    public func findInfoID(after info: Info) -> Info? {
//        guard let index = infos.firstIndex(of: info),
//                  infos.indices.contains(index + 1) else {
//            return nil
//        }
//        return infos[index + 1]
//    }
    
    
    
    public func findUnitByID(id: Int) -> Unit? {
        let result = units.filter { $0.id == id }
        if result.isEmpty {
            return nil
        }
        return result.first
    }
    
//    public func findLastInfo(byEventId eventID: Int) -> Info? {
//        if let result = infos.first(where: { $0.eventID == eventID }) {
//            return result
//        }
//        return nil
//    }

}


// MARK: - Additional Functions (move through indexies)

extension UnitModel {
    
//    public func nextInfo(after info: Info) -> Info? {
//        guard let index = infos.firstIndex(of: info),
//                  infos.indices.contains(index + 1) else {
//            return nil
//        }
//        return infos[index + 1]
//    }
//
//    public func prevInfo(before info: Info) -> Info? {
//        guard let index = infos.firstIndex(of: info),
//                  infos.indices.contains(index - 1) else {
//            return nil
//        }
//        return infos[index - 1]
//    }
    
}

// MARK: - DML SQL functions

//extension UnitModel {
//
//    // MARK: - SQL INSERT
//
//    public func sqlINSERT(
//        eventId: Int,
//        date: Date,
//        info: String,
//        note: String
//    )
//    async {
//
//        let sqlQueryINSERT = """
//            INSERT INTO
//                event.info(
//                    event_id,
//                    date,
//                    info,
//                    note
//                )
//            VALUES (
//                    $1,   -- event_id
//                    $2,   -- date
//                    $3,   -- info
//                    $4    -- note
//            )
//        """
//
//        do {
//            var configuration = PostgresClientKit.ConnectionConfiguration()
//            configuration.host = "217.107.219.91"
//            configuration.database = "tercas"
//            configuration.user = "postgres"
//            configuration.credential = .trust // .scramSHA256(password: "monrepo")
//
//            let connection = try PostgresClientKit.Connection(configuration: configuration)
//            defer { connection.close() }
//
//            let statement = try connection.prepareStatement(text: sqlQueryINSERT)
//            defer { statement.close() }
//
//            var datePg: PostgresDate {
//                return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
//            }
//
//            let _ = try statement.execute(
//                parameterValues: [
//                    eventId,
//                    datePg,
//                    info,
//                    note
//                ]
//            )
//        }
//        catch {
//            print(error)
//        }
//
//        await self.reload()
//    }
//
//
//    // MARK: - SQL UPDATE
//
//    // Variant 1
//    public func sqlUPDATE(
//        id: Int,
//        date: Date,
//        info: String,
//        note: String
//    ) async {
//
//        do {
//            var configuration = PostgresClientKit.ConnectionConfiguration()
//            configuration.host = "217.107.219.91"
//            configuration.database = "tercas"
//            configuration.user = "postgres"
//            configuration.credential = .trust
//
//            let connection = try PostgresClientKit.Connection(configuration: configuration)
//            defer { connection.close() }
//
//            let sqlQueryUPDATE = """
//                UPDATE
//                    event.vw_info
//                SET
//                    date = $2,  -- date
//                    info = $3,  -- info
//                    note = $4   -- note
//                WHERE
//                    id = $1     -- id
//            """
//            
//            let statement = try connection.prepareStatement(text: sqlQueryUPDATE)
//            defer { statement.close() }
//
//            var datePg: PostgresDate {
//                return date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
//            }
//
//            let _ = try statement.execute(
//                parameterValues: [
//                    id,
//                    datePg,
//                    info,
//                    note
//                ]
//            )
//        }
//        catch {
//            print(error)
//        }
//
//        await self.reload()
//    }
//
//    // Variant 2
//    public func sqlUPDATE(
//        info: Info
//    ) async {
//
//        let sqlQueryUPDATE = """
//            UPDATE
//                event.vw_info
//            SET
//                date = $2,  -- date
//                info = $3,  -- info
//                note = $4   -- note
//            WHERE
//                id = $1     -- id
//        """
//
//        do {
//            var configuration = PostgresClientKit.ConnectionConfiguration()
//            configuration.host = "217.107.219.91"
//            configuration.database = "tercas"
//            configuration.user = "postgres"
//            configuration.credential = .trust // .scramSHA256(password: "monrepo")
//
//            let connection = try PostgresClientKit.Connection(configuration: configuration)
//            defer { connection.close() }
//
//            let statement = try connection.prepareStatement(text: sqlQueryUPDATE)
//            defer { statement.close() }
//
//            var datePg: PostgresDate {
//                return info.date.postgresDate(in: TimeZone(secondsFromGMT: 0)!)
//            }
//
//            let _ = try statement.execute(
//                parameterValues: [
//                    info.id,
//                    datePg,
//                    info.info,
//                    info.note
//                ]
//            )
//        }
//        catch {
//            print(error)
//        }
//
//        await self.reload()
//    }
//
//
//    // MARK: - SQL DELETE
//
//    public func sqlDELETE(
//        id: Int
//    ) async {
//
//        let sqlQueryDELETE = """
//            DELETE FROM
//                event.info
//            WHERE
//                id = $1  -- id
//        """
//
//        do {
//            var configuration = PostgresClientKit.ConnectionConfiguration()
//            configuration.host = "217.107.219.91"
//            configuration.database = "tercas"
//            configuration.user = "postgres"
//            configuration.credential = .trust // .scramSHA256(password: "monrepo")
//
//            let connection = try PostgresClientKit.Connection(configuration: configuration)
//            defer { connection.close() }
//
//            let statement = try connection.prepareStatement(text: sqlQueryDELETE)
//            defer { statement.close() }
//
//            let _ = try statement.execute(
//                parameterValues: [
//                    id
//                ]
//            )
//        }
//        catch {
//            print(error)
//        }
//
//        await self.reload()
//    }
//}
