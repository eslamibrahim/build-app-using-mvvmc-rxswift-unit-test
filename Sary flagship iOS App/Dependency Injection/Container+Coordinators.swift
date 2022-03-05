import Swinject

extension Container {
    func registerCoordinators() {
    autoregister(SaryHomeCoordinatoor.self, argument: UINavigationController.self, initializer: SaryHomeCoordinatoor.init)
        autoregister(OtherTabsCoordinatoor.self, argument: UINavigationController.self, initializer: OtherTabsCoordinatoor.init)
        
    }
}
