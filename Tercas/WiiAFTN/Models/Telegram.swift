import SwiftUI

struct Telegram: Identifiable, Codable {
    var id = UUID()
    var title: String
    var samples: [String]? = nil
}

let telegramsList = [
    Telegram(title: "AFIL"),
    Telegram(title: "APZ"),
    Telegram(title: "FLA"),
    Telegram(title: "ALR"),
    Telegram(title: "ALD")
]

