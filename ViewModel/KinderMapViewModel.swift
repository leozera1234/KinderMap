import Foundation
import Combine

final class KinderMapViewModel: ObservableObject {
    enum Step {
        case welcome
        case childForm
        case questionnaire
        case dashboard
    }

    @Published var step: Step = .welcome
    @Published var child = ChildProfile()
    @Published var answers: [UUID: Bool] = [:]
    @Published var scores: [DomainScore] = []

    var questionsByDomain: [DevelopmentDomain: [DomainQuestion]] {
        Dictionary(grouping: questions, by: { $0.domain })
    }

    private let questions: [DomainQuestion] = [
        // Motor
        DomainQuestion(domain: .motor, text: "Corre e pula com facilidade?"),
        DomainQuestion(domain: .motor, text: "Consegue subir e descer escadas sem ajuda?"),
        // Linguagem
        DomainQuestion(domain: .language, text: "Forma frases de 3 ou mais palavras?"),
        DomainQuestion(domain: .language, text: "Compreende instruções simples do dia a dia?"),
        // Socioemocional
        DomainQuestion(domain: .social, text: "Brinca com outras crianças com interesse?"),
        DomainQuestion(domain: .social, text: "Consegue esperar a sua vez em jogos simples?"),
        // Cognição
        DomainQuestion(domain: .cognition, text: "Reconhece cores básicas (ex: vermelho, azul)?"),
        DomainQuestion(domain: .cognition, text: "Conta pelo menos até 5?"),
    ]

    // MARK: - Navegação

    func goToNextStep() {
        switch step {
        case .welcome:
            step = .childForm
        case .childForm:
            step = .questionnaire
        case .questionnaire:
            calculateScores()
            step = .dashboard
        case .dashboard:
            break
        }
    }

    func resetFlow() {
        child = ChildProfile()
        answers = [:]
        scores = []
        step = .welcome
    }

    // MARK: - Lógica de análise (simples, ilustrativa)

    private func calculateScores() {
        var tempScores: [DomainScore] = []

        for domain in DevelopmentDomain.allCases {
            let domainQuestions = questions.filter { $0.domain == domain }
            guard !domainQuestions.isEmpty else { continue }

            let total = Double(domainQuestions.count)
            let positives = domainQuestions.reduce(0.0) { partial, question in
                partial + (answers[question.id] == true ? 1.0 : 0.0)
            }

            let fraction = total > 0 ? positives / total : 0

            let (level, guidance) = interpretation(for: domain, score: fraction)

            tempScores.append(DomainScore(domain: domain,
                                          score: fraction,
                                          level: level,
                                          guidance: guidance))
        }

        scores = tempScores
    }

    private func interpretation(for domain: DevelopmentDomain, score: Double) -> (String, String) {
        switch score {
        case 0.8...1.0:
            return ("Muito bom", "Sinais positivos no domínio de \(domain.rawValue). Continue oferecendo experiências variadas e desafiadoras.")
        case 0.5..<0.8:
            return ("Em desenvolvimento", "O desenvolvimento em \(domain.rawValue) está em construção. Observe no dia a dia e incentive atividades relacionadas.")
        default:
            return ("Atenção", "Alguns marcos de \(domain.rawValue) podem precisar de apoio extra. Se possível, converse com um profissional de saúde ou educação.")
        }
    }
}

