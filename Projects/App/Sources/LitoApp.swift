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
    private let viewResolver: ViewResolver
    @ObservedObject private var coordinator: Coordinator
    
    init() {
        coordinator = Coordinator()
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        injector = DependencyInjector(container: Container())
        viewResolver = ViewResolver(injector: injector)
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly(coordinator: coordinator, viewResolver: viewResolver)
                          ])
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
            injector.resolve(LoginView.self)
//            RootTabView(viewResolver: viewResolver)
                    .navigationDestination(for: Page.self) { page in
                        page.getView(viewResolver: viewResolver)
                    }
            }
        }
    }
}
