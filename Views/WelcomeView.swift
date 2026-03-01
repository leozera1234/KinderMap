import SwiftUI

struct WelcomeView: View {
    let onStart: () -> Void
    var namespace: Namespace.ID

    var body: some View {
        ZStack {
            DesignSystem.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                // Hero Section
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(DesignSystem.Colors.primary.opacity(0.1))
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "hand.raised.fill")
                            .font(.system(size: 60))
                            .foregroundColor(DesignSystem.Colors.primary)
                    }
                    
                    VStack(spacing: 8) {
                        Text("KinderMap")
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .foregroundColor(DesignSystem.Colors.textPrimary)
                            .matchedGeometryEffect(id: "title", in: namespace)
                        
                        Text("Acompanhe cada passo do desenvolvimento com carinho e precisão.")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(DesignSystem.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                }
                
                // Info Cards
                VStack(spacing: 16) {
                    FeatureRow(icon: "chart.bar.fill", title: "Análise Profissional", description: "Baseado em marcos reais de crescimento.")
                    FeatureRow(icon: "heart.fill", title: "Feito para Pais", description: "Interface simples e acolhedora.")
                }
                .padding(.horizontal)
                
                Spacer()
                
                PrimaryButton(title: "Começar Avaliação") {
                    onStart()
                }
                .matchedGeometryEffect(id: "primaryButton", in: namespace)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(DesignSystem.Colors.secondary)
                .frame(width: 44, height: 44)
                .background(DesignSystem.Colors.secondary.opacity(0.1))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(DesignSystem.Colors.textSecondary)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}
