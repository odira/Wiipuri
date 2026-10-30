import PostgresClientKit
import SwiftUI
import Combine
import WiiKit


public class EventModel: Identifiable, ObservableObject {
    @Published public var isFetching: Bool = true
    @Published public var events = [Event]()
    
    @Published public var filteredEvents: [Event] = []
    @Published public var filter = EventModelFilter()
    
    static let shared = EventModel()
    
    
    init() {
        self.events = []
    }
    
    init(events: [Event]) {
        self.events.removeAll()
        self.events = events
    }
    
    deinit {
        self.events.removeAll()
    }
    

    @MainActor
    func reload() async {
        self.events.removeAll()
        await self.fetch()
    }
    
    @MainActor
    func fetch() async {
        self.isFetching = true
        
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "217.107.219.91"
            configuration.database = "tercas"
            configuration.user = "postgres"
            configuration.credential = .trust // .scramSHA256(password: "monrepo")
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer {
                connection.close()
            }
            
            let sqlText = """
                SELECT
                    id,                 --  0
                    event,              --  1
                    city,               --  2
                    _unit,              --  3
                    equipment,          --  4
                    phase,              --  5
                    years,              --  6
                    end_date,           --  7
                    description,        --  8
                    is_completed,       --  9
                    is_option,          -- 10
                    justification,      -- 11
                    limit_total,        -- 12
                    note,               -- 13
                    plan_id,            -- 14
                    is_valid,           -- 15
                    subgroup,           -- 16
                    subgroup_id,        -- 17
                    status_id,          -- 18
                    deal_id,            -- 19
                    deal_type_id,       -- 20
                    deal_status_id,     -- 21
                    deal,               -- 22
                    deal_price,         -- 23
                    deal_start_date,    -- 24
                    deal_end_date,      -- 25
                    deal_contractor_id, -- 26
                    deal_contractor,    -- 27
                    deal_subcontractor, -- 28
                    deal_senior_id,     -- 29
                    deal_senior,        -- 30
                    unit_id_arr         -- 31
                FROM
                    event.vw_event
            """
            
            let statement = try connection.prepareStatement(text: sqlText)
            defer {
                statement.close()
            }
            
            let cursor = try statement.execute()
            defer {
                cursor.close()
            }
            
            var tmpEvents: [Event] = []
            
            for row in cursor {
                let columns = try row.get().columns
                
                let id = try columns[0].int()                     ///  0
                let event = try columns[1].string()               ///  1
                let city = try? columns[2].string()               ///  2
                let unit = try? columns[3].string()               ///  3
                let equipment = try? columns[4].string()          ///  4
                let phase = try? columns[5].string()              ///  5
                let years = try? columns[6].string()              ///  6
                let endDate = try? columns[7].string()            ///  7
                let description = try? columns[8].string()        ///  8
                let isCompleted = try columns[9].bool()           ///  9
                let isOption = try columns[10].bool()             /// 10
                let justification = try? columns[11].string()     /// 11
                let limitTotal = try? columns[12].decimal()       /// 12
                let note = try? columns[13].string()              /// 13
                let planId = try columns[14].int()                /// 14
                let isValid = try columns[15].bool()              /// 15
                let subgroup = try? columns[16].string()          /// 16
                let subgroupId = try? columns[17].int()           /// 17
                let statusID = try? columns[18].int()             /// 18
                let dealID = try? columns[19].int()               /// 19
                let dealTypeID = try? columns[20].int()           /// 20
                let dealStatusID = try columns[21].int()          /// 21
                let deal = try? columns[22].string()              /// 22
                let dealPrice = try? columns[23].decimal()        /// 23
                let dealStartDatePg = try? columns[24].date()     /// 24
                let dealEndDatePg = try? columns[25].date()       /// 25
                let dealContractorID = try? columns[26].int()     /// 26
                let dealContractor = try? columns[27].string()    /// 27
                let dealSubcontractor = try? columns[28].string() /// 28
                let dealSeniorID = try? columns[29].int()         /// 29
                let dealSenior = try? columns[30].string()        /// 30
                let unitIdArr = try? columns[31].string()         /// 31
                ///
                print(unitIdArr)
                
                // The UTC/GMT time zone.
                let utcTimeZone = TimeZone(secondsFromGMT: 0)!
                
                var dealStartDate: Date? {
                    if let date = dealStartDatePg {
                        return date.date(in: utcTimeZone)
                    }
                    return nil
                }
                var dealEndDate: Date? {
                    if let date = dealEndDatePg {
                        return date.date(in: utcTimeZone)
                    }
                    return nil
                }
                
                tmpEvents.append(
                    Event(
                        id: id,                                 ///  0
                        event: event,                           ///  1
                        city: city,                             ///  2
                        unit: unit,                             ///  3
                        equipment: equipment,                   ///  4
                        phase: phase,                           ///  5
                        years: years,                           ///  6
                        endDate: endDate,                       ///  7
                        description: description,               ///  8
                        isCompleted: isCompleted,               ///  9
                        isOption: isOption,                     /// 10
                        justification: justification,           /// 11
                        limitTotal: limitTotal,                 /// 12
                        note: note,                             /// 13
                        planId: planId,                         /// 14
                        isValid: isValid,                       /// 15
                        subgroup: subgroup,                     /// 16
                        subgroupId: subgroupId,                 /// 17
                        statusID: statusID,                     /// 18
                        dealID: dealID,                         /// 19
                        dealTypeID: dealTypeID,                 /// 20
                        dealStatusID: dealStatusID,             /// 21
                        deal: deal,                             /// 22
                        dealPrice: dealPrice,                   /// 23
                        dealStartDate: dealStartDate,           /// 24
                        dealEndDate: dealEndDate,               /// 25
                        dealContractorID: dealContractorID,     /// 26
                        dealContractor: dealContractor,         /// 27
                        dealSubcontractor: dealSubcontractor,   /// 28
                        dealSeniorID: dealSeniorID,             /// 29
                        dealSenior: dealSenior,                 /// 30
                        unitIdArr: [1, 2, 3]
                    )
                )
                
//                DispatchQueue.main.async {
//                    self.events = tmpEvents
//                }
                
                self.events = tmpEvents
            }
        } catch {
            print("Database error: \(error)")
        }
        
        isFetching = false
    }
}

// MARK: - EventModel Example extension

#if DEBUG
public extension EventModel {
    
    static let eventExamples: [Event] = [
        Event.example,
        Event.example,
        Event.example
    ]
    
    static let example = samples[0]
    static let samples: [EventModel] = [
        EventModel(events: eventExamples),
        EventModel(events: eventExamples),
        EventModel(events: eventExamples)
    ]
    
}
#endif

public extension EventModel {
    func findEventById(_ id: Int) -> Event? {
        let result = events.filter { $0.id == id }
        if result.isEmpty {
            return nil
        } else {
            return result.first
        }
    }
}
