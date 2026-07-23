import SwiftUI

public struct ActivitySearchView: View {
    @EnvironmentObject var activityModel: ActivityModel
    
    @Binding var activityId: Int
    
    @State private var inputText: String = ""
    @FocusState private var nameInFocus: Bool
    
    private var filteredActivities: [Activity] {
        return activityModel.activities.filter {
            $0.activity.lowercased().contains(inputText.lowercased())
        }
    }
    
    public init(activityId: Binding<Int>) {
        self._activityId = activityId
    }
        
    public var body: some View {
        VStack {
            HStack {
                TextField("Enter activity for search", text: $inputText)
                    .disableAutocorrection(true)
                    #if os(iOS)
                        .autocapitalization(.none)
                    #endif
                    .padding()
                    #if os(iOS)
                        .border(Color(UIColor.separator))
                    #endif
                    .focused($nameInFocus)
                Button("Clear") {
                    inputText = ""
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            if filteredActivities.count > 0 {
                List {
                    ForEach(filteredActivities) { activity in
                        Text(activity.activity)
                            .onTapGesture {
                                inputText = activity.activity
                                activityId = activity.id
                            }
                    }
                }
//                .listStyle(GroupedListStyle())
            }
            Spacer()
        }
        .onAppear {
            if let activity = activityModel.findActivity(byId: self.activityId) {
                self.inputText = activity.activity
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
              self.nameInFocus = true
            }
        }
    }
}

struct ActivitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySearchView(activityId: .constant(33))
            .environmentObject(ActivityModel())
    }
}
