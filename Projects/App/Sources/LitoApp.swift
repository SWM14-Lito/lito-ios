import SwiftUI
import Presentation
import Domain
import Swinject

@main
struct LitoApp: App {
    private let injector: Injector
    private let viewResolver: ViewResolver
    
    init() {
        injector = DependencyInjector(container: Container())
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly()
                          ])
        viewResolver = ViewResolver(injector: injector)
    }

    var body: some Scene {
        WindowGroup {
            RootTabView(coordinator: Coordinator.instance, viewResolver: viewResolver)
        }
    }
}

struct Previews_LitoApp_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(homeUseCase: StubHomeUseCase()))
    }
}
