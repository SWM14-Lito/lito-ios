import SwiftUI
import Data
import Presentation
import Domain
import Swinject
import KakaoSDKCommon

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
        initView()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                EmptyView()
                    .navigationDestination(for: Page.self) { page in
                        coordinator.buildPage(page: page)
                    }
            }
        }
    }
    
    private func initView() {
        coordinator.push(.loginView)
    }
}
