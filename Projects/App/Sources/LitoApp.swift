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
    @ObservedObject private var coordinator: Coordinator
    
    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        injector = DependencyInjector(container: Container())
        coordinator = Coordinator()
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly(coordinator: coordinator)
                          ])
        coordinator.injector = injector
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.buildView(page: .loginView)
                    .navigationDestination(for: Page.self) { page in
                        coordinator.buildView(page: page)
                    }
            }
        }
    }
}
