import SwiftUI

struct ChildFormView: View {
    @ObservedObject var viewModel: KinderMapViewModel
    var namespace: Namespace.ID

    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Sobre a criança")
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .matchedGeometryEffect(id: "title", in: namespace)

                Text("Algumas informações ajudam a interpretar melhor o desenvolvimento.")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.appSecondaryBackground.opacity(0.9))
                .overlay(
                    VStack(spacing: 16) {
                        TextField("Nome da criança", text: $viewModel.child.name)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color.appSystemBackground)
                            )

                        Picker("Gênero", selection: $viewModel.child.gender) {
                            ForEach(Gender.allCases) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                        .pickerStyle(.segmented)

                        DatePicker("Data de nascimento",
                                   selection: $viewModel.child.birthDate,
                                   in: ...Date(),
                                   displayedComponents: .date)
                        .font(.system(.body, design: .rounded))
                    }
                    .padding(18)
                )

            Spacer()

            PrimaryButton(title: "Continuar") {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.9)) {
                    viewModel.goToNextStep()
                }
            }
            .matchedGeometryEffect(id: "primaryButton", in: namespace)
            .disabled(viewModel.child.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(viewModel.child.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1)
        }
    }
}

