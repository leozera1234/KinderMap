import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: KinderMapViewModel
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            DesignSystem.Colors.background.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // Header with animation
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            DesignSystem.Typography.titleLarge("Análise")
                                .matchedGeometryEffect(id: "title", in: namespace)
                            Spacer()
                            Button(action: { viewModel.reset() }) {
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(DesignSystem.Colors.primary)
                            }
                        }
                        
                        Text("Resultados para \(viewModel.child.name)")
                            .font(.headline)
                            .foregroundColor(DesignSystem.Colors.primary)
                        
                        Text("Este resumo mostra o desempenho da criança nos quatro pilares fundamentais do desenvolvimento.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(DesignSystem.Colors.textSecondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Metrics List
                    VStack(spacing: 20) {
                        ForEach(viewModel.domainScores) { score in
                            PremiumProgressRow(domain: score.domain, percentage: score.score)
                        }
                    }
                    .frame(maxWidth: 800)
                    .padding(.horizontal)
                    
                    // Disclaimer
                    Text("Nota: Avaliações digitais são ferramentas de triagem e não substituem o acompanhamento de pediatras ou especialistas.")
                        .font(.caption)
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    
                    Spacer(minLength: 50)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
