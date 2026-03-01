import Foundation

struct ChildProfile {
    var name: String = ""
    var gender: Gender = .unspecified
    var birthDate: Date = Calendar.current.date(byAdding: .year, value: -2, to: Date()) ?? Date()
    
    var ageInMonths: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: birthDate, to: Date())
        return components.month ?? 0
    }
}
