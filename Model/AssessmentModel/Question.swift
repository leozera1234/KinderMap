import Foundation

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let domain: DevelopmentDomain
}