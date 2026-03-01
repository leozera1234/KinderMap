import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case female = "Feminino"
    case male = "Masculino"
    case other = "Outro"
    case unspecified = "Não informado"

    var id: String { rawValue }
}
