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
        let useCase = FetchDogFamiliesDictionaryFromServiceUseCase(breedsNetworkProvider: provider)
        shared.register(useCase as FetchDogFamiliesDictionaryFromServiceUseCaseContract)
    }
    
    private static func registerGetPersistedDogBreedsUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = GetPersistedDogFamiliesUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as GetPersistedDogFamiliesUseCaseContract)
    }
    
    private static func registerStoreDogBreedUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = StoreDogFamiliesUseCase(provider: provider)
        shared.register(useCase as StoreDogFamiliesUseCaseContract)
    }
    
    private static func registerGetPersistedDogBreedsCountUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = GetPersistedDogFamiliesCountUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as GetPersistedDogFamiliesCountUseCaseContract)
    }
    
    private static func registerFetchDogBreedsFromLocalOrRemoteUseCase() {
        let getPersistedDogFamiliesCountUseCase: GetPersistedDogFamiliesCountUseCaseContract = shared.resolve()
        let fetchDogFamiliesFromServiceUseCase: FetchDogFamiliesDictionaryFromServiceUseCaseContract = shared.resolve()
        let getPersistedDogBreedsUseCase: GetPersistedDogFamiliesUseCaseContract = shared.resolve()
        let storeDogBreedsUseCase: StoreDogFamiliesUseCaseContract = shared.resolve()
        let useCase = FetchDogFamiliesFromLocalOrRemoteUseCase(getPersistedDogFamiliesCountUseCase: getPersistedDogFamiliesCountUseCase,
                                                               fetchDogFamiliesFromServiceUseCase: fetchDogFamiliesFromServiceUseCase,
                                                               getPersistedDogFamiliesUseCase: getPersistedDogBreedsUseCase,
                                                               storeDogFamiliesUseCase: storeDogBreedsUseCase)
        shared.register(useCase as FetchDogFamiliesFromLocalOrRemoteUseCaseContract)
    }
}
