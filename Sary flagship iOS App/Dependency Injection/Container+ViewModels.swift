import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        autoregister(SaryHomeDashboardViewModel.self, initializer: SaryHomeDashboardViewModel.init)
    }
}
