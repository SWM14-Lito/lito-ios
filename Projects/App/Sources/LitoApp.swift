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
    @ObservedObject private var toastHelper: ToastHelper
    
    init() {
        UIFont.registerCommonFonts()
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        
        injector = DependencyInjector(container: Container())
        toastHelper = ToastHelper()
        coordinator = Coordinator(.loginScene)
        if KeyChainManager.isPossibleAutoLogin {
            coordinator.push(.rootTabScene)
        }
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly(
                            coordinator: coordinator,
                            toastHelper: toastHelper
                           )])
        coordinator.injector = injector
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
