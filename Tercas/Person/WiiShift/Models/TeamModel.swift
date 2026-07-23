import Foundation
import Combine
import WiiKit
import SwiftUI

public class TeamViewModel: ObservableObject {
    @Published var persons: [Person] = [Person]()
    
    public init() {
        persons = PersonModel().persons
    }
}
