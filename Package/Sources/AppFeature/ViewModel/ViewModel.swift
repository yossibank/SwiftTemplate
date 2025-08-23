import AppExtension
import Combine

public protocol LogicProtocol {
    associatedtype State
    associatedtype Dependency = Void
    associatedtype Output = Void
}

@MainActor
open class ViewModel<Logic: LogicProtocol>: ObservableObject {
    public typealias State = Logic.State
    public typealias Dependency = Logic.Dependency
    public typealias Output = Logic.Output

    @Published public var state: State

    public let dependency: Logic.Dependency
    public let output: AnyPublisher<Output, Never>

    private let outputSubject = NeverSubject<Output>()

    private var cancellables = Set<AnyCancellable>()

    public required init(
        state: State,
        dependency: Dependency
    ) {
        self.state = state
        self.dependency = dependency
        self.output = outputSubject.eraseToAnyPublisher()
    }

    public convenience init(state: State) where Dependency == Void {
        self.init(state: state, dependency: ())
    }

    public func send(_ output: Output) {
        outputSubject.send(output)
    }
}
