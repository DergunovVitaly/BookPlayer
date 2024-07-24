//
//  ExperienceExampleApproach.swift
//  BookPlayer
//
//  Created by Vitaliy on 22.07.2024.
//

import Foundation
import UIKit
import SwiftUI

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}

class StateData<T> {
    var state: T
    var message: String?
    
    init(state: T) {
        self.state = state
    }
    
    init(state: T, message: String? = nil) {
        self.state = state
        self.message = message
    }
}

enum ViewModelState {
    case idle
    case inProgress
    case finished
    case error
}

enum AuthState {
    case idle
    case started
    case loggedIn
    case accountCreated
    case identityInfoPopulated
    case addressUpdated
    case identityVerified
    case phoneVerificationCodeSent
    case phoneVerificationCodeResent
    case phoneVerified
    case forgotPassSent
    case finishedGettingUserData(error: String?, data: Data?)
    case error(text: String?)
    case updatedProfile
}

protocol AuthViewModel {
    // MARK: - Instance properties
    var stateData: Dynamic<StateData<AuthState>> { get }
    var phoneNumber: String? { get }
    var phoneCC: String? { get }
    var dayOfBirth: Int? { get }
    var monthOfBirth: Int? { get }
    var yearOfBirth: Int? { get }
    var isContinuedAuthorization: Bool { get }
    
    // MARK: - Methods
    func runBiometricsAuthorization()
    func getUserData()
    func verifyAccount()
    func forgotPassword(of email: String)
    func sendVerificationCode(number: String, cc: String)
    func resendVerificationCode()
    func verifyCode(code: String)
    func updateAddress()
    func getCountries()
    func initiateLocationManager()
    func initiateAddress()
    func collectAddressData(streetName: String?, streetNumber: String?, city: String?, state: String?, zipcode: String?)
    func updateFirstAndLastName(firstName: String?, lastName: String?)
}

final class AuthViewModelImpl: AuthViewModel {
    var isContinuedAuthorization: Bool
    var stateData: Dynamic<StateData<AuthState>> = Dynamic(StateData(state: .idle))
    
    // MARK: - Lifecycle
    init(isContinuedAuthorization: Bool = false) {
        self.isContinuedAuthorization = isContinuedAuthorization
    }
    
    // MARK: - Instance properties
    var phoneNumber: String?
    var phoneCC: String?
    var dayOfBirth: Int?
    var monthOfBirth: Int?
    var yearOfBirth: Int?
    
    func runBiometricsAuthorization() {}
    
    func getUserData() {
        stateData.value = .init(state: .started)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.stateData.value = .init(state: .accountCreated)
        }
    }
    
    func verifyAccount() {}
    func forgotPassword(of email: String) {}
    func sendVerificationCode(number: String, cc: String) {}
    func resendVerificationCode() {}
    func verifyCode(code: String) {}
    func updateAddress() {}
    func getCountries() {}
    func initiateLocationManager() {}
    func initiateAddress() {}
    func collectAddressData(streetName: String?, streetNumber: String?, city: String?, state: String?, zipcode: String?) {}
    func updateFirstAndLastName(firstName: String?, lastName: String?) {}
}

final class LoginViewController: UIViewController {
    // MARK: - Properties
    let viewModel: AuthViewModel = AuthViewModelImpl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
        viewModel.getUserData()
    }
    
    // MARK: - Setup views
    func setupViewModel() {
        viewModel.stateData.bind { /*[weak self]*/ (stateData) in
//            guard let self = self else { return }
            switch stateData.state {
            case .idle:
                break
            case .started:
                print("state started")
            case .loggedIn:
                print("state loggedIn")
            case .accountCreated:
                print("state accountCreated")
            case .identityInfoPopulated:
                print("state identityInfoPopulated")
            case .addressUpdated:
                print("state addressUpdated")
            case .error(let text):
                print("error \(text ?? "")")
            case .finishedGettingUserData:
                print("finishedGettingUserData")
            case .identityVerified:
                print("identityVerified")
            case .phoneVerificationCodeSent:
                print("phoneVerificationCodeSent")
            case .phoneVerificationCodeResent:
                print("phoneVerificationCodeResent")
            case .phoneVerified:
                print("phoneVerified")
            case .forgotPassSent:
                print("forgotPassSent")
            case .updatedProfile:
                print("updatedProfile")
            }
        }
    }
}


struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> LoginViewController {
        let viewController = LoginViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        
    }
}
