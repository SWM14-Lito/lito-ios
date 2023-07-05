import SwiftUI
import Presentation
import Domain
import Swinject

@main
struct LitoApp: App {
    private let injector: Injector
    private let viewResolver: ViewResolver
    @ObservedObject private var coordinator: Coordinator
    
    init() {
        coordinator = Coordinator()
        injector = DependencyInjector(container: Container())
        viewResolver = ViewResolver(injector: injector)
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly(coordinator: coordinator)
                          ])
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
            RootTabView(viewResolver: viewResolver)
                    .navigationDestination(for: Page.self) { page in
                        page.getView(viewResolver: viewResolver)
                    }
            }
        }
    }
}

struct Previews_LitoApp_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(homeUseCase: StubHomeUseCase()))
    }
}
