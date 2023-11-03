//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Matheus Valbert on 01/09/23.
//

import Foundation
import DataComponents

public final class ProfileViewModel {
    
    private let fetchProfileUseCase: FetchProfileUseCase
    private let updateProfileUseCase: UpdateProfileUseCase
    private let fetchUserProfileFromServerUseCase: FetchUserProfileFromServerUseCase
    private let deleteAccountUseCase: DeleteAccountUseCase
    
    var profile: UserDomain?
    
    init(fetchProfileUseCase: FetchProfileUseCase, updateProfileUseCase: UpdateProfileUseCase, fetchUserProfileFromServerUseCase: FetchUserProfileFromServerUseCase, deleteAccountUseCase: DeleteAccountUseCase) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.updateProfileUseCase = updateProfileUseCase
        self.fetchUserProfileFromServerUseCase = fetchUserProfileFromServerUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
    }
    
    func fetchProfile() async {
        do {
            profile = try await fetchProfileUseCase.execute()
        } catch {
            fatalError("User not found")
        }
    }
    
    func fetchUserProfileFromServer() async {
        do {
            profile = try await fetchUserProfileFromServerUseCase.execute()
        } catch {
            fatalError("User not found")
        }
    }
    
    func updateProfile(username: String, language: String) async {
        do {
            try await updateProfileUseCase.execute(username: username, language: Languages(rawValue: language.lowercased())!)
        } catch {
            fatalError("User cannot be updated")
        }
    }
    
    func deleteAccount() async {
        do {
            try await deleteAccountUseCase.execute()
        } catch {
            fatalError("User cannot be deleted")
        }
    }
}
