import SwiftUI

public struct ActivityCard: View {
    let activity: Activity
    
    public init(for activity: Activity) {
        self.activity = activity
    }
    
    public var body: some View {
        HStack {
            if let icon = activity.icon {
                Text(icon)
            }
            Text(activity.activity)
                .foregroundColor(activity.color)
        }
        .font(.headline)
        .bold()
    }
}

struct ActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCard(for: Activity.example)
    }
}
