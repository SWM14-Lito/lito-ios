import SwiftUI
import Data
import Presentation
import Domain
import Swinject
import KakaoSDKCommon
import SWMLogging

@main
struct LitoApp: App {
    private let injector: Injector
    @ObservedObject private var coordinator: Coordinator
    @ObservedObject private var toastHelper: ToastHelper
    
    init() {
        UIFont.registerCommonFonts()
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        
        injector = DependencyInjector(container: Container())
        toastHelper = ToastHelper()
        coordinator = Coordinator(.loginScene)
        // TODO: 우리 서버 API에 맞게 주소 변경 필요
        let logger = SWMLogger(serverUrl: "https://dev.swm-lgtm.com", serverPath: "/v1/log", OSNameAndVersion: "iOS 16", appVersion: "1.0")
        injector.assemble([DomainAssembly(logger: logger),
                           DataAssembly(),
                           PresentationAssembly(
                            coordinator: coordinator,
                            toastHelper: toastHelper,
                            logger: logger
                           )])
        coordinator.injector = injector
        if KeyChainManager.isPossibleAutoLogin {
            coordinator.push(.rootTabScene)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.buildInitialScene()
                    .navigationDestination(for: AppScene.self) { scene in
                        coordinator.buildScene(scene: scene)
                    }
                    .sheet(item: $coordinator.sheet) { scene in
                        coordinator.buildScene(scene: scene)
                    }
            }
            .toast(message: $toastHelper.toastMessage, duration: $toastHelper.duration, isToastShown: $toastHelper.isToastShown)
        }
    }
}
