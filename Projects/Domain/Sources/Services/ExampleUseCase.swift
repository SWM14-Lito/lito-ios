import Combine
import Foundation

public protocol ExampleUseCase {
    func load() -> AnyPublisher<SlipVO, Error>
}

public final class DefaultExampleUseCase: ExampleUseCase {
    
    let repository: ExampleRepository
    
    public init(repository: ExampleRepository) {
        self.repository = repository
    }
    
    public func load() -> AnyPublisher<SlipVO, Error> {
        return repository.loadSlip()
    }
}

#if DEBUG
public final class StubExampleUseCase: ExampleUseCase {
    
    public init() {}
    
    public func load() -> AnyPublisher<SlipVO, Error> {
        return Just(SlipVO.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
#endif
