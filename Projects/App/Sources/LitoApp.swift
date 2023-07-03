import SwiftUI
import Data
import Presentation
import Domain
import Swinject
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct LitoApp: App {
    private let injector: Injector
    
    init() {
        KakaoSDK.initSDK(appKey: "ef1b461bf006b7bd5460a4ec15236fe1")
        injector = DependencyInjector(container: Container())
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly()
                          ])
    }
    
    var body: some Scene {
        WindowGroup {
//            HomeView(viewModel: injector.resolve(HomeViewModel.self))
            LoginView(viewModel: .init(useCase: DefaultLoginUseCase(repository: DefaultLoginRepository()))).onOpenURL(perform: { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
