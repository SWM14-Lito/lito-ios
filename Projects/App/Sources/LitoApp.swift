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
    
    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
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
