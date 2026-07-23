import SwiftUI

public struct ActivityPicker: View {
    @EnvironmentObject var activityModel: ActivityModel
    
    @Binding var selection: Int
    
    public init(selection: Binding<Int>) {
        self._selection = selection
    }
    
    public var body: some View {
        Picker("Activity", selection: $selection) {
            ForEach(activityModel.activities) {
                Text($0.activity).tag($0.id)
            }
        }
    }
}

struct ActivityPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityPicker(selection: .constant(Activity.example.id))
                .preferredColorScheme(.light)
            ActivityPicker(selection: .constant(Activity.example.id))
                .preferredColorScheme(.dark)
        }
        .environmentObject(ActivityModel())
        .previewLayout(.sizeThatFits)
    }
}
