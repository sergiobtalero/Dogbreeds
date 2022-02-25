import Domain
import Data

public final class DependencyContainer {
    private var dependencies = [String: AnyObject]()
    private static var shared = DependencyContainer()

    // MARK: - Methods
    public static func register<T>(_ dependency: T) {
        shared.register(dependency)
    }

    static func resolve<T>() -> T {
        shared.resolve()
    }

    private func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency as AnyObject
    }

    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T

        precondition(dependency != nil, "No dependency found for \(key)! must register a dependency before resolve.")

        return dependency!
    }
}

// MARK: - Public methods
extension DependencyContainer {
    public static func removeAllDependencies() {
        shared.dependencies.removeAll()
    }
    
    public static func registerUseCases() {
        Self.registerGetDogBreedsUseCase()
    }
}

// MARK: - Private methods
private extension DependencyContainer {
    private static func registerGetDogBreedsUseCase() {
        let provider = DogBreedsNetworkProvider(breedsService: BreedsService())
        let useCase = GetDogBreedsUseCase(breedsNetworkProvider: provider)
        shared.register(useCase as GetDogBreedUseCaseContract)
    }
}