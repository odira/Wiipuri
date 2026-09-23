import SwiftUI
import WiiKit

struct MorderDetailsView: View {
    @EnvironmentObject var morderModel: MorderModel
    @EnvironmentObject var personModel: PersonModel
    
    @State private var isPresentedEditView: Bool = false
    
    let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        formatter.usesGroupingSeparator = false
        return formatter
    }()
    
    // MARK: - Init
    
    @Binding var morder: Morder
    
    init(for morder: Binding<Morder>) {
        self._morder = morder
    }
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section("MAIN INFORMATION") {
                HStack {
                    Text("Номер приказа")
                    Spacer()
                    Text(numberFormatter.string(from: NSNumber(value: morder.number))!)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Дата издания приказа")
                    Spacer()
                    Text(morder.date, style: .date)
                        .bold()
                        .lineLimit(1)
                        .bold()
                        .padding(5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                HStack {
                    Text("Кем издан")
                    Spacer()
                    if let department = morder.department {
                        Text(department)
                            .foregroundColor(.secondary)
                    }
                }
                HStack {
                    Text("Заголовок")
                    Spacer()
                    if let title = morder.title {
                        Text(title)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            if let personId = morder.personId {
                Section("СПЕЦИАЛИСТ") {
                    if let person = personModel.findPerson(byId: personId) {
                        PersonCard(for: person, style: .regular)
                    } else {
                        Text("Not personalized")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            if let body = morder.body {
                Section("Текст приказа") {
                    Text(body)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
            }
            
            if let note = morder.note {
                Section("Примечание") {
                    Text(note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Детализация приказа")
        
        /// Navigation Toolbar
        ///
        .navigationBarItems(
            trailing: HStack {
                Button("Edit") {
                    isPresentedEditView.toggle()
                }
            }
        )
        /// Edit Sheet
        ///
        .sheet(isPresented: $isPresentedEditView) {
            NavigationStack {
                MorderEditView(morder: $morder)
                    .navigationTitle("Редактировать приказ")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                isPresentedEditView.toggle()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Apply") {
//                                morder.update(with: morderData)
                                morderModel.sqlMorderUPDATE(morder)
                                isPresentedEditView.toggle()
                            }
                        }
                    }
            }
        }
    }
}

struct MorderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MorderDetailsView(for: .constant(Morder.example))
                .preferredColorScheme(.light)
            MorderDetailsView(for: .constant(Morder.example))
                .preferredColorScheme(.dark)
        }
        .environmentObject(MorderModel.example)
        .environmentObject(PersonModel.example)
        .previewLayout(.sizeThatFits)
    }
}
