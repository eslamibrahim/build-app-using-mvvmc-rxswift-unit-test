import Swinject
import SwinjectAutoregistration

extension Container {
    func registerServices() {
    autoregister(SaryHomeService.self, initializer: SaryHomeServiceManager.init).inObjectScope(.container)

    }
}
