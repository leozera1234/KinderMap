import SwiftUI

struct QuestionnaireView: View {
    @ObservedObject var viewModel: KinderMapViewModel

    var body: some View {
        ZStack {
            DesignSystem.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Avaliação")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text(viewModel.child.name)
                            .font(.subheadline)
                            .foregroundColor(DesignSystem.Colors.primary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.white)
                
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(DevelopmentDomain.allCases) { domain in
                            if let questions = viewModel.questionsByDomain[domain] {
                                DomainCard(domain: domain, questions: questions, answers: $viewModel.answers)
                            }
                        }
                    }
                    .padding()
                }
                
                PrimaryButton(title: "Ver Resultados") {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.9)) {
                        viewModel.goToNextStep()
                    }
                }
                .padding()
                .background(Color.white)
            }
        }
        .navigationBarHidden(true)
    }
}

struct DomainCard: View {
    let domain: DevelopmentDomain
    let questions: [DomainQuestion]
    @Binding var answers: [UUID: Bool]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(domain.rawValue)
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .foregroundColor(domain.color)
                    .tracking(1.5)
                Spacer()
                Image(systemName: iconFor(domain))
                    .foregroundColor(domain.color)
            }
            
            Divider()
            
            VStack(spacing: 2) {
                ForEach(questions) { question in
                    Toggle(isOn: Binding(
                        get: { answers[question.id] ?? false },
                        set: { answers[question.id] = $0 }
                    )) {
                        Text(question.text)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(DesignSystem.Colors.textPrimary)
                    }
                    .padding(.vertical, 12)
                    .toggleStyle(SwitchToggleStyle(tint: domain.color))
                    
                    if question.id != questions.last?.id {
                        Divider().opacity(0.5)
                    }
                }
            }
        }
        .premiumCard()
    }
    
    private func iconFor(_ domain: DevelopmentDomain) -> String {
        switch domain {
        case .motor: return "figure.walk"
        case .language: return "bubble.left.fill"
        case .social: return "person.2.fill"
        case .cognition: return "brain.fill"
        }
    }
}
