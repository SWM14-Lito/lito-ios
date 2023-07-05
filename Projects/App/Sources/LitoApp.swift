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
        injector = DependencyInjector(container: Container())
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly()
                          ])
        viewResolver = ViewResolver(injector: injector)
        coordinator = Coordinator.instance
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
//            HomeView(viewModel: injector.resolve(HomeViewModel.self))
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
