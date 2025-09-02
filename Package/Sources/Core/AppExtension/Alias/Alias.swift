import Combine

public typealias VoidBlock = () -> Void
public typealias NeverPublisher<T> = AnyPublisher<T, Never>
public typealias NeverSubject<T> = PassthroughSubject<T, Never>
