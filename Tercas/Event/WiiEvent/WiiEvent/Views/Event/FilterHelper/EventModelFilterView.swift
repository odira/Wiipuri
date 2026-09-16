//
//  EventFilterView.swift
//  WiiEvent
//
//  Created by Vladimir Ilin on 10.07.2025.
//

import SwiftUI

// MARK: - EventModelFilterView definition

struct EventModelFilterView: View {
    @EnvironmentObject private var eventModel: EventModel
    @EnvironmentObject private var planModel: PlanModel
    @EnvironmentObject private var dealModel: DealModel
    @EnvironmentObject private var eventModelFilter: EventModelFilter
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Город")) {
                        cityBlock
                    }
                    
                    Section(header: Text("Выберите план")) {
                        planIdBlock
                    }
                    
                    Section(header: Text("Статус договора")) {
                        dealStatusBlock
                    }
                    
                    Section(header: Label("Номер Договора/Контракта", systemImage: "magnifyingglass")) {
                        dealBlock
                    }
                    
                    Section {
                        eventIsValidBlock
                    }
                    
                    Section {
                        showIsOptionBlock
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Search") {
                        update()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
    
    private func update() {
        eventModelFilter.filteredEvents = eventModelFilter.filterEvents(eventModel.events)
    }
}


// MARK: - EventModelFilter Visual Blocks

extension EventModelFilterView {
    
    // city
    @ViewBuilder
    private var cityBlock: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Search", text: $eventModelFilter.city)
//                    .textFieldStyle(.roundedBorder)
                Button("Clear") {
                    eventModelFilter.city = ""
                }
                .buttonStyle(.borderedProminent)
                .keyboardShortcut("c", modifiers: [.command])
            }
        }
    }
    
    // planId
    @ViewBuilder
    private var planIdBlock: some View {
        VStack(alignment: .leading) {
            HStack {
                Picker("Централизованный план", selection: $eventModelFilter.planId) {
                    ForEach(planModel.plans) { plan in
                        Text(plan.plan).tag(plan.id)
                    }
                }
            }
        }
    }
    
    // dealStatus
    @ViewBuilder
    private var dealStatusBlock: some View {
        VStack(alignment: .leading ) {
            HStack {
                Picker("Статус договора", selection: $eventModelFilter.dealStatus) {
                    Text("Все").tag(nil as Deal.Status?)
                    ForEach(Deal.Status.allCases) { status in
                        Text(status.rawValue.capitalized).tag(Deal.Status?.some(status))
                    }
                }
            }
        }
    }
    
    // deal
    @ViewBuilder
    private var dealBlock: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Введите номер договора/контракта", text: $eventModelFilter.deal)
//                    .textFieldStyle(.roundedBorder)
                Button("Clear") {
                    eventModelFilter.deal = ""
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    // eventIsValidBlock
    @ViewBuilder
    private var eventIsValidBlock: some View {
        HStack {
            Toggle(isOn: $eventModelFilter.isValid) {
                Text("Показывать только валидные")
            }
        }
    }
    
    // showIsOptionBlock
    private var showIsOptionBlock: some View {
        HStack {
            Toggle(isOn: $eventModelFilter.isOption) {
                Text("Показывать опцион")
            }
        }
    }
}


// MARK: - EventModelFilter View Preview

#Preview {
    EventModelFilterView()
        .environmentObject(EventModel.example)
        .environmentObject(EventModelFilter.shared)
        .environmentObject(PlanModel.example)
        .environmentObject(DealModel.example)
}
