import SwiftUI
import WiiKit

struct MorderEditView: View {
    @EnvironmentObject var morderModel: MorderModel
    @EnvironmentObject var personModel: PersonModel
    
    @State private var isPresentedDateView: Bool = false
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.zeroSymbol = ""
        formatter.decimalSeparator = ""
        formatter.groupingSeparator = ""
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Init
    
    @Binding var morder: Morder
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section("INFORMATION") {
                HStack {
                    Text("Номер приказа")
                    Spacer()
                    TextField("Номер приказа", value: $morder.number, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .keyboardType(.numberPad)
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("Дата издания приказа")
                    Spacer()
                    Button(dateFormatter.string(from: morder.date)) {
                        isPresentedDateView.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isPresentedDateView) {
                        DatePicker(
                            "Выберите дату приказа",
                            selection: $morder.date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }
                HStack {
                    Text("Кем издан")
                    Spacer()
                    
                    TextField(
                        "Введите department",
                        text: Binding(
                            get: { morder.department ?? "" },
                            set: { morder.department = $0} )
                    )
                    .foregroundColor(.blue)
                }
                HStack {
                    Text("Заголовок")
                    Spacer()
                    
                    TextField(
                        "Введите заголовок приказа",
                        text: Binding(
                            get: { morder.title ?? "" },
                            set: { morder.title = $0 } )
                    )
                    .foregroundColor(.blue)
                }
            }
            
            Section("Работник") {
                NavigationStack {
                    NavigationLink(destination: PersonSearchView(byId: $morder.personId)) {
                        if let id = morder.personId {
                            let person = personModel.findPerson(byId: id)
                            PersonCard(for: person!, style: .regular)
                        } else {
                            Button("Add new Person") { }
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            
            Section("Текст приказа") {
                TextEditor(
                    text: Binding(
                        get: { morder.body ?? "" },
                        set: { morder.body = $0 })
                )
                .foregroundColor(.blue)
                .font(.footnote)
                .frame(height: 150)
            }

            Section("Примечание") {
                TextEditor(
                    text: Binding(
                        get: { morder.note ?? "" },
                        set: { morder.note = $0 })
                )
                .font(.caption)
                .foregroundColor(.blue)
                .frame(height: 150)
            }
        }
    }
}

struct MorderEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MorderEditView(morder: .constant(Morder.example))
                .preferredColorScheme(.light)
            MorderEditView(morder: .constant(Morder.example))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(MorderModel.example)
        .environmentObject(PersonModel.example)
    }
}
