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
        Self.registerGetPersistedDogBreedsUseCase()
        Self.registerStoreDogBreedUseCase()
        Self.registerGetPersistedDogBreedsCountUseCase()
        Self.registerFetchDogBreedsFromLocalOrRemoteUseCase()
    }
}

// MARK: - Private methods
private extension DependencyContainer {
    private static func registerGetDogBreedsUseCase() {
        let provider = DogBreedsNetworkProvider(breedsService: BreedsService())
        let useCase = FetchDogBreedsDictionaryFromServiceUseCase(breedsNetworkProvider: provider)
        shared.register(useCase as FetchDogBreedsDictionaryFromServiceUseCaseContract)
    }
    
    private static func registerGetPersistedDogBreedsUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = GetPersistedDogBreedsUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as GetPersistedDogBreedsUseCaseContract)
    }
    
    private static func registerStoreDogBreedUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = StoreDogBreedsUseCase(provider: provider)
        shared.register(useCase as StoreDogBreedsUseCaseContract)
    }
    
    private static func registerGetPersistedDogBreedsCountUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = GetPersistedDogbreedsCountUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as GetPersistedDogBreedsCountUseCaseContract)
    }
    
    private static func registerFetchDogBreedsFromLocalOrRemoteUseCase() {
        let getPersistedDogBreedsCountUseCase: GetPersistedDogBreedsCountUseCaseContract = shared.resolve()
        let fetchDogBreedsDictionaryUseCase: FetchDogBreedsDictionaryFromServiceUseCaseContract = shared.resolve()
        let getPersistedDogBreedsUseCase: GetPersistedDogBreedsUseCaseContract = shared.resolve()
        let storeDogBreedsUseCase: StoreDogBreedsUseCaseContract = shared.resolve()
        let useCase = FetchDogBreedsFromLocalOrRemoteUseCase(getPersistedDogBreedsCountUseCase: getPersistedDogBreedsCountUseCase,
                                                             fetchDogBreedsFromServiceUseCase: fetchDogBreedsDictionaryUseCase,
                                                             getPersistedDogBreedsUseCase: getPersistedDogBreedsUseCase,
                                                             storeDogBreedsUseCase: storeDogBreedsUseCase)
        shared.register(useCase as FetchDogBreedsFromLocalOrRemoteUseCaseContract)
    }
}
