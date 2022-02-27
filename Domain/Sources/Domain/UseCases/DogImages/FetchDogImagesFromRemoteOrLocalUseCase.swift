//
//  File.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation

public protocol FetchDogImagesFromRemoteOrLocalUseCaseContract {
    func execute(dogBreedName: String, familyName: String?) async throws -> [BreedImage]
}

public enum FetchDogImagesFromRemoteOrLocalUseCaseError: Error {
    case general
}

public final class FetchDogImagesFromRemoteOrLocalUseCase {
    private let getDogImagesFromServiceUseCase: GetDogImagesFromServiceUseCaseContract
    private let getPersistedDogBreedImagesCountUseCase: GetPersistedDogBreedImagesCountUseCaseContract
    private let getPersistedDogBreedImagesUseCase: GetPersistedDogBreedImagestUseCaseContract
    private let updateDogBreedWithImagesUseCase: UpdateDogBreedWithImagesUseCaseContract
    
    // MARK: - Initializer
    public init(getDogImagesFromServiceUseCase: GetDogImagesFromServiceUseCaseContract,
                getPersistedDogBreedImagesCountUseCase: GetPersistedDogBreedImagesCountUseCaseContract,
                getPersistedDogBreedImagesUseCase: GetPersistedDogBreedImagestUseCaseContract,
                updateDogBreedWithImagesUseCase: UpdateDogBreedWithImagesUseCaseContract) {
        self.getDogImagesFromServiceUseCase = getDogImagesFromServiceUseCase
        self.getPersistedDogBreedImagesCountUseCase = getPersistedDogBreedImagesCountUseCase
        self.getPersistedDogBreedImagesUseCase = getPersistedDogBreedImagesUseCase
        self.updateDogBreedWithImagesUseCase = updateDogBreedWithImagesUseCase
    }
}

// MARK: - FetchDogImagesFromRemoteOrLocalUseCaseContract
extension FetchDogImagesFromRemoteOrLocalUseCase: FetchDogImagesFromRemoteOrLocalUseCaseContract {
    public func execute(dogBreedName: String, familyName: String?) async throws -> [BreedImage] {
        let dogBreedImagesCount = getPersistedDogBreedImagesCountUseCase.execute(dogBreedName: dogBreedName)
        if dogBreedImagesCount > .zero {
            return getPersistedDogBreedImagesUseCase.execute(dogBreedName: dogBreedName)
        }
        
        do {
            let imagesArray = try await getDogImagesFromServiceUseCase.execute(breedName: getSearchText(dogBreedName: dogBreedName,
                                                                                                        familyName: familyName))
            updateDogBreedWithImagesUseCase.execute(dogBreedName: dogBreedName, images: imagesArray)
            return getPersistedDogBreedImagesUseCase.execute(dogBreedName: dogBreedName)
        } catch {
            throw FetchDogImagesFromRemoteOrLocalUseCaseError.general
        }
    }
    
    private func getSearchText(dogBreedName: String,
                               familyName: String?) -> String {
        if let familyName = familyName {
            return "\(familyName)/\(dogBreedName)"
        } else {
            return dogBreedName
        }
    }
}
