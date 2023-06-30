import Combine
import Foundation

public protocol HomeUseCase {
    func load() -> AnyPublisher<SlipVO, NetworkErrorVO>
}

public final class DefaultHomeUseCase: HomeUseCase {
    
    let repository: HomeRepository
    
    public init(repository: HomeRepository) {
        self.repository = repository
    }
    
    public func load() -> AnyPublisher<SlipVO, NetworkErrorVO>{
        return repository.loadSlip()
    }
}

#if DEBUG
public final class StubHomeUseCase: HomeUseCase {
    
    public init() {}
    
    public func load() -> AnyPublisher<SlipVO, NetworkErrorVO> {
        return Just(SlipVO.mock)
            .setFailureType(to: NetworkErrorVO.self)
            .eraseToAnyPublisher()
    }
    
}
#endif
