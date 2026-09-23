import Foundation
import Combine
import PostgresClientKit
import SwiftUI
import os.log

public class PeriodModel: ObservableObject {
    @Published public var periods = [Period]()
    
    @ObservedObject var global = Global.shared
    
    private let sqlQuerySELECT = """
        SELECT
            id,           -- 0
            person_id,    -- 1
            activity_id,  -- 2
            planning,     -- 3
            period,       -- 4
            note          -- 5
        FROM
            calendar.vw_empl_shedule
        WHERE
            period::daterange && daterange($1, $2, '[]')
            AND
            planning IS FALSE
        ORDER BY
            period;
    """
    
    public init() {
        reload()
    }
    
    public func reload() {
        periods = []
        fetchData()
        
        let message = "PeriodModel was reloaded..."
        let osLog = OSLog(subsystem: "WiiPeriodCalendar", category: "")
        os_log(.default, log: osLog, "%{public}@", message as CVarArg)
    }
    
    func fetchData() {
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQuerySELECT)
            defer { statement.close() }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let cursor = try statement.execute(
                parameterValues: [
                    formatter.string(from: global.startInterval), /// $1
                    formatter.string(from: global.endInterval)    /// $2
                ]
            )
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()
                let personId = try columns[1].int()
                let activityId = try columns[2].int()
                let planning = try columns[3].bool()
                let period = try? columns[4].string().toDateInterval()
                let note = try? columns[5].string()
                
                self.periods.append(
                    Period(
                        id: id,
                        personId: personId,
                        activityId: activityId,
                        planning: planning,
                        period: period!,
                        note: note
                    )
                )
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Additional Functions

public extension PeriodModel {
    func findPeriod(for person: Person, at date: Date) -> Period? {
        var personPeriods: [Period] {
            var periods: [Period] = []
            for period in self.periods {
                if period.personId == person.id {
                    periods.append(period)
                }
            }
            return periods
        }
        
        for period in personPeriods {
            if period.period.contains(date) {
                return period
            }
        }
        
        return nil
    }
}

// MARK: - SQL functions

extension PeriodModel {
    // MARK: - SQL UPDATE
    
    public func sqlPeriodUPDATE(_ period: Period) {
        let sqlQueryUPDATE = """
        UPDATE calendar.vw_empl_shedule
        SET person_id=$2,
            activity_id=$3,
            planning=$4,
            start_date=$5,
            end_date=$6,
            note=$7
        WHERE
            id=$1
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryUPDATE)
            defer { statement.close() }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let _ = try statement.execute(
                parameterValues: [
                    String(period.id),
                    String(period.personId),
                    String(period.activityId),
                    period.planning,
                    formatter.string(from: period.period.start),
                    formatter.string(from: period.period.end),
                    period.note
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
    
    
    // MARK: - SQL INSERT
    
    public func sqlPeriodINSERT(_ period: Period) {
        let sqlQueryINSERT = """
        INSERT INTO
            calendar.vw_empl_shedule(
                person_id,    -- 1
                activity_id,  -- 2
                planning,     -- 3
                start_date,   -- 4
                end_date,     -- 5
                note          -- 6
            )
        VALUES (
                $1,  -- person_id
                $2,  -- activity_id
                $3,  -- planning
                $4,  -- start_date
                $5,  -- end_date
                $6   -- note
        )
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryINSERT)
            defer { statement.close() }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let _ = try statement.execute(
                parameterValues: [
                    String(period.personId),
                    String(period.activityId),
                    period.planning,
                    formatter.string(from: period.period.start),
                    formatter.string(from: period.period.end),
                    period.note
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
    
    // MARK: - SQL DELETE
    
    // Delete by id
    public func sqlPeriodDELETE(byId: Int) {
        let sqlQueryDELETE = """
        DELETE FROM
            calendar.vw_empl_shedule
        WHERE
            id=$1  -- id
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryDELETE)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [
                    String(byId)
                ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
    
    // Delete by period
    public func sqlPeriodDELETE(_ period: Period) {
        let sqlQueryDELETE = """
        DELETE FROM
            calendar.vw_empl_shedule
        WHERE
            id=$1  -- id
        """
        
        do {
            let connection = try PostgresClientKit.Connection(configuration: pgConfiguration)
            defer { connection.close() }
            
            let statement = try connection.prepareStatement(text: sqlQueryDELETE)
            defer { statement.close() }
            
            let _ = try statement.execute(
                parameterValues: [ String(period.id) ]
            )
        }
        catch {
            print(error)
        }
        
        self.reload()
    }
}
