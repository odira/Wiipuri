import SwiftUI

struct EventDetailsView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var eventModel: EventModel
    @EnvironmentObject var historyModel: HistoryModel
    
    let id: Int


    var body: some View {
        VStack {
            if let event = eventModel.findEventById(id) {
                VStack {
                    Form {
                        
                        Section {
                            VStack(alignment: .center, spacing: 10) {
                                CircleImage(image: event.image)
                                
                                if let deal = event.deal {
                                    HStack {
                                        Text("\(event.dealTypeAbbrText) №")
                                        Text(deal).bold()
                                        if let startDate = event.dealStartDate {
                                            Text("от \(DateFormatter.longDateFormatter.string(from: startDate))")
                                        }
                                    }
                                }
                                
                                Text(event.event)
                                    .bold()
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        Section("Справочная информация") {
                            NavigationLink(destination: DescriptionView(for: event.description)) {
                                Text("Описание")
                            }
                            NavigationLink(destination: JustificationView(for: event.justification)) {
                                Text("Обоснование")
                            }
                            NavigationLink(destination: InfoListView(for: event)) {
                                Text("Справочная информация")
                            }
                            NavigationLink(destination: HistoryListView(for: event)) {
                                Text("Исполнение по мероприятию")
                            }
                        }
                        Section("Реквизиты договора/контракта") {
                            LabeledContent("Дата заключения", value: "N/A")
                            LabeledContent("Дата окончания", value: event.endDate ?? "")
                        }
                        Section("Исполнение договора") {
                            LabeledContent("Год реализации", value: event.years ?? "")
                            LabeledContent("Ответственный исполнитель", value: event.dealSenior ?? "")
                        }
                        Section("Стоимость мероприятия") {
                            LabeledContent("Общая стоимость (руб.)", value: event.limitTotal ?? 0, format: .number)
                            NavigationLink(destination: EventLimitView(event: event)) {
                                Text("Стоимость по годам")
                            }
                        }
                        Section("Орган ОВД") {
                            LabeledContent("Орган ОВД", value: event.unit ?? "")
                            LabeledContent("Город", value: event.city ?? "")
                        }
                        Section("Оборудование") {
                            LabeledContent("Оборудование", value: event.equipment ?? "")
                            LabeledContent("Вид работ (наименование этапа)", value: event.phase ?? "")
                        }
                        Section("Подрядчик") {
                            LabeledContent("Контрагент", value: event.dealContractor ?? "")
                            LabeledContent("Субподрядчик", value: event.dealSubcontractor ?? "")
                        }
                        
                    }
                    .formStyle(.grouped)
                }
            }
        }
    }
}

#Preview {
    EventDetailsView(id: Event.example.id)
        .frame(width: 600, height: 800)
        .environmentObject(EventModel.example)
        .environmentObject(HistoryModel.example)
}

struct ButtonBlockView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
