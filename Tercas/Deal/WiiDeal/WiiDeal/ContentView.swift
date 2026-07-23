//
//  ContentView.swift
//  WiiDeal
//
//  Created by Wiipuri Developer on 05.01.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dealViewModel: DealViewModel
    
    private var filteredDeals: [Deal] {
        dealViewModel.deals
    }
    
    @State private var selection: Deal.ID? = nil
    
    
    var body: some View {
        Group {
            
            Table(of: Deal.self,
                  selection: $selection,
                  columns: {
                TableColumn("Номер") { deal in
                    if deal.deal != nil {
                        Text(deal.type) + Text(" № ") + Text(deal.deal!).bold()
                    } else {
                        Text("")
                    }
                }
                TableColumn("Дата заключения") { deal in
                    VStack(alignment: .leading) {
                        Text(deal.startingDate, format: .dateTime)
                            .foregroundStyle(.blue)
                    }
                }
                TableColumn("Дата закрытия") { deal in
                    VStack(alignment: .leading) {
                        if let date = deal.endingDate {
                            Text(date, format: .dateTime)
                                .foregroundStyle(.blue)
                        }
                    }
                }
                
                //            public var id: Int                      //  0
                //            public var typeID: Int                  //  1
                //            public var typeAbbr: String             //  2
                //            public var type: String                 //  3
                //            public var isPlanning: Bool             //  4
                //            public var isCompleted: Bool            //  5
                //            public var deal: String?                //  6
                //            public var startingDate: Date           //  7
                //            public var endingDate: Date?            //  8
                //            public var note: String?                //  9
                //            public var parentID: Int?               // 10
                //            public var eventID: Int                 // 11
                //            public var justificatoin: String?       // 12
                //            public var description: String?         // 13
            }, rows: {
                ForEach(filteredDeals) { deal in
                    if deal.typeID != 3 {
                        TableRow(deal)
                    } else {
//                        var parentDeal: Deal = dealViewModel.deals.first(where: { $0.id == deal.parentID })
                        let parentDeal: Deal = dealViewModel.findDealByID(id: deal.parentID!)!
                        DisclosureTableRow(parentDeal) {
                            TableRow(deal)
                        }
                    }
                }
            })
            .task {
                await dealViewModel.fetch()
            }
            .inspector(isPresented: .constant(selection != nil)) {
                if let selection,
                   let deal = dealViewModel.deals.first(where: { $0.id == selection }) as Deal? {
                    if deal.deal != nil {
                        Text(deal.type) + Text(" № ") + Text(deal.deal!).bold()
                    } else {
                        Text("")
                    }
                }
            }
            /// Table
            
        } /// Group
    } /// body
}

#Preview {
    ContentView()
        .environmentObject(DealViewModel.example)
}
