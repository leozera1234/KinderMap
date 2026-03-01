import Foundation

enum DevelopmentDomain: String, CaseIterable, Identifiable {
    case cognitive = "Cognitive"
    case language = "Language"
    case motor = "Motor"
    case social = "Social"
    
    var id: String { rawValue }
}