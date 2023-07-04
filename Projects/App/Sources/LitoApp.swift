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
            ProfileSettingView(viewModel: ProfileSettingViewModel(), name: "홍길동")
        }
    }
}

struct Previews_LitoApp_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(homeUseCase: StubHomeUseCase()))
    }
}
