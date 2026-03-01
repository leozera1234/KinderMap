import Foundation

struct DomainQuestion: Identifiable {
    let id = UUID()
    let domain: DevelopmentDomain
    let text: String
}

