import SwiftUI
import Combine

enum AppStep {
    case welcome
    case childForm
    case questionnaire
    case dashboard
}

final class KinderMapViewModel: ObservableObject {
    @Published var step: AppStep = .welcome
    @Published var child = ChildProfile()
    @Published var answers: [UUID: Bool] = [:]
    @Published var domainScores: [DomainScore] = []
    
    // Data filtering logic
    var filteredQuestions: [DevelopmentDomain: [DomainQuestion]] {
        // In a real app, this would filter by child.ageInMonths
        // For now, we provide a structured set of questions
        MockDataService.shared.getQuestions(for: child.ageInMonths)
    }
    
    var questionsByDomain: [DevelopmentDomain: [DomainQuestion]] {
        filteredQuestions
    }
    
    func goToNextStep() {
        switch step {
        case .welcome:
            step = .childForm
        case .childForm:
            step = .questionnaire
        case .questionnaire:
            calculateResults()
            step = .dashboard
        case .dashboard:
            reset()
        }
    }
    
    private func calculateResults() {
        // Logic to calculate percentages per domain
        var scores: [DomainScore] = []
        for domain in DevelopmentDomain.allCases {
            let domainQuestions = questionsByDomain[domain] ?? []
            let total = domainQuestions.count
            if total > 0 {
                let positive = domainQuestions.filter { answers[$0.id] == true }.count
                let percentage = (Double(positive) / Double(total)) * 100.0
                scores.append(DomainScore(domain: domain, score: percentage))
            }
        }
        self.domainScores = scores
    }
    
    func reset() {
        step = .welcome
        child = ChildProfile()
        answers = [:]
        domainScores = []
    }
}

// Mock Data Service for the professional flow
struct MockDataService {
    static let shared = MockDataService()
    
    func getQuestions(for ageInMonths: Int) -> [DevelopmentDomain: [DomainQuestion]] {
        // Simplified mock questions for demonstration
        var dict: [DevelopmentDomain: [DomainQuestion]] = [:]
        
        dict[.motor] = [
            DomainQuestion(domain: .motor, text: "A criança caminha de forma independente?"),
            DomainQuestion(domain: .motor, text: "Consegue subir degraus pequenos com apoio?")
        ]
        
        dict[.language] = [
            DomainQuestion(domain: .language, text: "Fala pelo menos 10 palavras isoladas?"),
            DomainQuestion(domain: .language, text: "Aponta para objetos conhecidos quando nomeados?")
        ]
        
        dict[.social] = [
            DomainQuestion(domain: .social, text: "Imita gestos simples (ex: dar tchau)?"),
            DomainQuestion(domain: .social, text: "Demonstra afeto por pessoas conhecidas?")
        ]
        
        dict[.cognition] = [
            DomainQuestion(domain: .cognition, text: "Encontra objetos escondidos sob sua vista?"),
            DomainQuestion(domain: .cognition, text: "Rabisca espontaneamente com giz ou lápis?")
        ]
        
        return dict
    }
}
