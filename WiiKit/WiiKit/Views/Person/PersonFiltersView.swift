import SwiftUI

public struct PersonFiltersView: View {
    @Binding var isPresented: Bool
    @ObservedObject var personFilters: PersonFilters
    
    public init(isPresented: Binding<Bool>, personFilters: PersonFilters) {
        self._isPresented = isPresented
        self.personFilters = personFilters
    }

    public var body: some View {
        VStack {
            Form {
                Section {
                    Text("Valid")
                    Picker("Valid", selection: $personFilters.byValid) {
                        Text("all")
                        Text("valid")
                        Text("invalid")
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text("Enter name")
                    TextField("Enter name here", text: $personFilters.byName)
                        .textFieldStyle(.roundedBorder)
                }
                Section {
                    Text("Enter middlename")
                    TextField("Enter middlename here", text: $personFilters.byMiddlename)
                        .textFieldStyle(.roundedBorder)
                }
                Section {
                    Text("Введите фамилию")
                    TextField("Введите фамилию здесь", text: $personFilters.bySurname)
                        .textFieldStyle(.roundedBorder)
                }
        
                Section {
                    Text("Выберите смену")
                    Picker("Смена", selection: $personFilters.byShiftNum) {
                        ForEach(1...6, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            HStack {
                Button(role: .none, action: {
                    self.isPresented = false
                }, label: {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                })
                    .buttonStyle(.bordered)
                    .tint(.green)

                Button(role: .destructive, action: {
                    self.isPresented = false
                }, label: {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                })
                    .buttonStyle(.bordered)
                    .tint(.red)
            }
            .padding()
        }
    }
}

struct PersonFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        PersonFiltersView(isPresented: .constant(true), personFilters: PersonFilters())
    }
}
