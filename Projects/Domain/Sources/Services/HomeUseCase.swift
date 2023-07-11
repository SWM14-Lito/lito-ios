import Combine
import Foundation

public protocol HomeUseCase {
    func load() -> AnyPublisher<SlipVO, Error>
}

public final class DefaultHomeUseCase: HomeUseCase {
    
    let repository: HomeRepository
    
    public init(repository: HomeRepository) {
        self.repository = repository
    }
    
    public func load() -> AnyPublisher<SlipVO, Error>{
        return repository.loadSlip()
    }
}
