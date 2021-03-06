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
        Self.registerDogImagesFormServiceUseCase()
        Self.registerGetPersistedDogBreedImagesCountUseCase()
        Self.registerGetPersistedDogBreedImagesUseCase()
        Self.registerUpdateDogBreedWithImagesUseCase()
        Self.registerFetchDogImagesFromRemoteOrLocalUseCase()
        Self.registerToggleLikeStatusOfDogImageUseCase()
        Self.registerGetFavoritedImagesUseCase()
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
    
    private static func registerDogImagesFormServiceUseCase() {
        let provider = DogBreedsNetworkProvider(breedsService: BreedsService())
        let useCase = GetDogImagesFromServiceUseCase(breedsNetworkProvider: provider)
        shared.register(useCase as GetDogImagesFromServiceUseCaseContract)
    }
    
    private static func registerGetPersistedDogBreedImagesCountUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = GetPersistedDogBreedImagesCountUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as GetPersistedDogBreedImagesCountUseCaseContract)
    }
    
    private static func registerGetPersistedDogBreedImagesUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = GetPersistedDogBreedImagesUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as GetPersistedDogBreedImagestUseCaseContract)
    }
    
    private static func registerUpdateDogBreedWithImagesUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = UpdateDogBreedWithImagesUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as UpdateDogBreedWithImagesUseCaseContract)
    }
    
    private static func registerFetchDogImagesFromRemoteOrLocalUseCase() {
        let getDogImagesFromServiceUseCase: GetDogImagesFromServiceUseCaseContract = shared.resolve()
        let getPersistedDogBreedImagesCountUseCase: GetPersistedDogBreedImagesCountUseCaseContract = shared.resolve()
        let getPersistedDogBreedImagesUseCase: GetPersistedDogBreedImagestUseCaseContract = shared.resolve()
        let updateDogBreedWithImagesUseCase: UpdateDogBreedWithImagesUseCaseContract = shared.resolve()
        let useCase = FetchDogImagesFromRemoteOrLocalUseCase(getDogImagesFromServiceUseCase: getDogImagesFromServiceUseCase,
                                                             getPersistedDogBreedImagesCountUseCase: getPersistedDogBreedImagesCountUseCase,
                                                             getPersistedDogBreedImagesUseCase: getPersistedDogBreedImagesUseCase,
                                                             updateDogBreedWithImagesUseCase: updateDogBreedWithImagesUseCase)
        shared.register(useCase as FetchDogImagesFromRemoteOrLocalUseCaseContract)
    }
    
    private static func registerToggleLikeStatusOfDogImageUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = ToggleLikeStatusOfDogImageUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as ToggleLikeStatusOfDogImageUseCaseContract)
    }
    
    private static func registerGetFavoritedImagesUseCase() {
        let provider = DogBreedsPersistedProvider(coreDataManager: CoreDataManager.shared)
        let useCase = GetFavoritedImagesUseCase(dogBreedsPersistedProvider: provider)
        shared.register(useCase as GetFavoritedImagesUseCaseContract)
    }
}
