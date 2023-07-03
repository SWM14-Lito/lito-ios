import SwiftUI
import Presentation
import Domain
import Swinject

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
            LoginView(viewModel: .init())
        }
    }
}
