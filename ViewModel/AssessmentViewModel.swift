import Combine

final class AssessmentViewModel: ObservableObject {

    private let scoringService: ScoreCalculating
    private let interpretationService: InterpretationCalculating
    private let jsonLoader = JSONLoaderService()

    @Published var questions: [Question] = []
    @Published var results: [DomainResult] = []

    init(
        scoringService: ScoreCalculating = ScoringService(),
        interpretationService: InterpretationCalculating = InterpretationService()
    ) {
        self.scoringService = scoringService
        self.interpretationService = interpretationService
    }

    func loadQuestions(for stage: DevelopmentStage) {
        let allQuestions = jsonLoader.loadQuestions()
        questions = allQuestions.filter { $0.stage == stage }
    }

    func finalize(answers: [QuestionAnswer]) {
        let scores = scoringService.calculateScores(answers: answers)
        results = interpretationService.interpret(domainScores: scores)
    }
}