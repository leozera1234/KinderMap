import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case female = "Feminino"
    case male = "Masculino"
    case unspecified = "Prefiro não informar"

    var id: String { rawValue }
}

