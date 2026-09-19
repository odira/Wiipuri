import SwiftUI
import CoreLocation

public struct History: Hashable, Codable, Identifiable {
    public var id: Int                   //  0
    public var eventID: Int              //  1
    public var date: Date                //  2
    public var history: String           //  3
    public var answerTo: String?         //  4
    public var ref: String?              //  5
    public var note: String?             //  6
    public var recvLetterNum: String?    //  7
    public var recvLetterDate: Date?     //  8
    public var recvManufacturerId: Int?  //  9
    public var recvUnitId: Int?          // 10
    public var sendLetterNum: String?    // 11
    public var sendLetterDate: Date?     // 12
    public var sendManufacturerId: Int?  // 13
    public var sendUnitId: Int?          // 14
    
    
    public init(
        id: Int,                         //  0
        eventID: Int,                    //  1
        date: Date,                      //  2
        history: String,                 //  3
        answerTo: String? = nil,         //  4
        ref: String? = nil,              //  5
        note: String? = nil,             //  6
        recvLetterNum: String? = nil,    //  7
        recvLetterDate: Date? = nil,     //  8
        recvManufacturerId: Int? = nil,  //  9
        recvUnitId: Int? = nil,          // 10
        sendLetterNum: String? = nil,    // 11
        sendLetterDate: Date? = nil,     // 12
        sendManufacturerId: Int? = nil,  // 13
        sendUnitId: Int? = nil           // 14
    ) {
        self.id = id                                  //  0
        self.eventID = eventID                        //  1
        self.date = date                              //  2
        self.history = history                        //  3
        self.answerTo = answerTo                      //  4
        self.ref = ref                                //  5
        self.note = note                              //  6
        self.recvLetterNum = recvLetterNum            //  7
        self.recvLetterDate = recvLetterDate          //  8
        self.recvManufacturerId = recvManufacturerId  //  9
        self.recvUnitId = recvUnitId                  // 10
        self.sendLetterNum = sendLetterNum            // 11
        self.sendLetterDate = sendLetterDate          // 12
        self.sendManufacturerId = sendManufacturerId  // 13
        self.sendUnitId = sendUnitId                  // 14
    }
}

// MARK: - History example

#if DEBUG
public extension History {
    
    static let example = samples[0]
    
    static let samples: [History] = [
        History(
            id: 10,                                                  //  0
            eventID: 100,                                            //  1
            date: Date(timeIntervalSince1970: 1_000_000),            //  2
            history: "TEST HISTORY TEST HISTORY TEST",               //  3
            answerTo: "Letter 101",                                  //  4
            ref: "Letter 100",                                       //  5
            note: "TEST HISTORY TEST HISTORY TEST",                  //  6
            recvLetterNum: "Letter recv",                            //  7
            recvLetterDate: Date(timeIntervalSince1970: 1_100_000),  //  8
            recvManufacturerId: 100,                                 //  9
            recvUnitId: 100,                                         // 10
            sendLetterNum: "Letter send",                            // 11
            sendLetterDate: Date(timeIntervalSince1970: 1_100_000),  // 12
            sendManufacturerId: 101,                                 // 13
            sendUnitId: 101                                          // 14
        )
    ]
    
}
#endif
