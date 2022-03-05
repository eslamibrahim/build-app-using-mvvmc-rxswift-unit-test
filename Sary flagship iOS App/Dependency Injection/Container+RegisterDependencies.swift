import Swinject

extension Container {
    func registerDependencies() {
        registerServices()
        registerRepositories()
        registerCoordinators()
        registerViewModels()
    }
}
