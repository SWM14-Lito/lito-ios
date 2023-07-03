import SwiftUI
import Data
import Presentation
import Domain
import Swinject
import KakaoSDKCommon

@main
struct LitoApp: App {
    private let injector: Injector
    
    init() {
        injector = DependencyInjector(container: Container())
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly()
                          ])
    }

    var body: some Scene {
        WindowGroup {
//            HomeView(viewModel: injector.resolve(HomeViewModel.self))
            LoginView(viewModel: .init(useCase: DefaultLoginUseCase(repository: DefaultLoginRepository())))
        }
    }
}
