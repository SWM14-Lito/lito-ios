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
    private let logger: SWMLogger
    
    init() {
        UIFont.registerCommonFonts()
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        // Logging 객체 생성
        // Logging.init(mandatory 요소)
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        
        injector = DependencyInjector(container: Container())
        toastHelper = ToastHelper()
        coordinator = Coordinator(.loginScene)
        // OS NameAndVersion 기기에서 불러오기
        logger = SWMLogger(serverUrl: "https://dev.swm-lgtm.com", serverPath: "/v1/log", OSNameAndVersion: "iOS 16")
        // domainAssembly 에 Logging 객체 주입
        injector.assemble([DomainAssembly(logger: logger),
                           DataAssembly(),
                           PresentationAssembly(
                            coordinator: coordinator,
                            toastHelper: toastHelper
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
