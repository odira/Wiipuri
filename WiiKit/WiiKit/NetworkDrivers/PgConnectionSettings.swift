import Foundation
import Combine
import PostgresClientKit

class pgServerSettings {
    @Published var host: String {
        didSet { UserDefaults.standard.set(host, forKey: "host") }
    }
    @Published var user: String {
        didSet { UserDefaults.standard.set(user, forKey: "user") }
    }
    @Published var database: String {
        didSet { UserDefaults.standard.set(database, forKey: "database") }
    }
    @Published var socketTimeout: Int {
        didSet { UserDefaults.standard.set(socketTimeout, forKey: "socketTimeout") }
    }
    
    init() {
        self.host = UserDefaults.standard.object(forKey: "host") as? String ?? "217.107.219.91"
        self.user = UserDefaults.standard.object(forKey: "user") as? String ?? "postgres"
        self.database = UserDefaults.standard.object(forKey: "database") as? String ?? "tercas"
        self.socketTimeout = UserDefaults.standard.object(forKey: "socketTimeout") as? Int ?? 10
    }
}

class pgLocalhostSettings {
    @Published var host: String {
        didSet { UserDefaults.standard.set(host, forKey: "host") }
    }
    @Published var user: String {
        didSet { UserDefaults.standard.set(user, forKey: "user") }
    }
    @Published var database: String {
        didSet { UserDefaults.standard.set(database, forKey: "database") }
    }
    @Published var socketTimeout: Int {
        didSet { UserDefaults.standard.set(socketTimeout, forKey: "socketTimeout") }
    }
    
    init() {
        self.host = UserDefaults.standard.object(forKey: "host") as? String ?? "127.0.0.1"
        self.user = UserDefaults.standard.object(forKey: "user") as? String ?? "postgres"
        self.database = UserDefaults.standard.object(forKey: "database") as? String ?? "tercas"
        self.socketTimeout = UserDefaults.standard.object(forKey: "socketTimeout") as? Int ?? 10
    }
}

var pgSettings = pgServerSettings()
//var pgSettings = pgLocalhostSettings()

public var pgConfiguration: PostgresClientKit.ConnectionConfiguration {
    var configuration = PostgresClientKit.ConnectionConfiguration()
    configuration.host = pgSettings.host
    configuration.user = pgSettings.user
    configuration.database = pgSettings.database
    configuration.ssl = false
    configuration.credential = .trust
    configuration.socketTimeout = pgSettings.socketTimeout
    return configuration
}

func pgConnection(_ configuration: PostgresClientKit.ConnectionConfiguration) -> PostgresClientKit.Connection? {
    if let connection = try? PostgresClientKit.Connection(configuration: configuration) {
        return connection
    } else {
        print("Error")
        return nil
    }
}

var connection: PostgresClientKit.Connection? {
    pgConnection(pgConfiguration)
}
