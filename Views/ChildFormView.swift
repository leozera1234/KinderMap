import SwiftUI

struct ChildFormView: View {
    @ObservedObject var viewModel: KinderMapViewModel
    var namespace: Namespace.ID

    var body: some View {
        ZStack {
            DesignSystem.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Dados da Criança")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                        .matchedGeometryEffect(id: "title", in: namespace)
                    
                    Text("Preencha as informações para personalizarmos a avaliação.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Form Card
                VStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nome Completo")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(DesignSystem.Colors.primary)
                        
                        TextField("Ex: Leonardo Fernandes", text: $viewModel.child.name)
                            .padding()
                            .background(DesignSystem.Colors.background)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Data de Nascimento")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(DesignSystem.Colors.primary)
                        
                        DatePicker("", selection: $viewModel.child.birthDate, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(maxHeight: 150)
                            .clipped()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Gênero")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(DesignSystem.Colors.primary)
                        
                        Picker("Gênero", selection: $viewModel.child.gender) {
                            Text("Masculino").tag(Gender.male)
                            Text("Feminino").tag(Gender.female)
                            Text("Outro").tag(Gender.other)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .premiumCard()
                .padding(.horizontal)
                
                Spacer()
                
                PrimaryButton(title: "Continuar para Questões") {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.9)) {
                        viewModel.goToNextStep()
                    }
                }
                .matchedGeometryEffect(id: "primaryButton", in: namespace)
                .padding(.horizontal)
                .padding(.bottom, 40)
                .disabled(viewModel.child.name.isEmpty)
                .opacity(viewModel.child.name.isEmpty ? 0.6 : 1.0)
            }
        }
    }
}
