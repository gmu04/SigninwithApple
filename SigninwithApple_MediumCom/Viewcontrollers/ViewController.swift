// ViewController.swift by Gokhan Mutlu on 5.03.2023

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	
}

//MARK: - ASAuthorizationControllerPresentationContextProviding

extension ViewController: ASAuthorizationControllerPresentationContextProviding{
	func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
		return self.view.window!
	}
}

//MARK: - ASAuthorizationControllerDelegate

extension ViewController: ASAuthorizationControllerDelegate{
	//authentication successful
	func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
		switch authorization.credential {
			case let appleIDCredential as ASAuthorizationAppleIDCredential:
				
				let userIdentifier = appleIDCredential.user
				let fullName = appleIDCredential.fullName
				let email = appleIDCredential.email ?? "no-email"
				
				print("\(userIdentifier), \(String(describing: fullName)), \(email)")
				//user authenticated and run your app
				
			default:
				break
			}
	}
	
	// Handle error
	func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
		/*
		 https://developer.apple.com/documentation/authenticationservices/asauthorizationerror/code
		 */
		guard let error = error as? ASAuthorizationError else { return }
		switch error.code {
			case .canceled:
				print("Sign in with Apple cancelled by user")
			//...
				
			default:
				print(error.localizedDescription)
		}
		
	}
}



//MARK: - UI

extension ViewController{
	
	fileprivate func setupUI(){
		self.addSigninButton()
	}

	fileprivate func addSigninButton(){
		let authorizationButton = ASAuthorizationAppleIDButton()
		authorizationButton.translatesAutoresizingMaskIntoConstraints = false
		authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
	   
		view.addSubview(authorizationButton)
		NSLayoutConstraint.activate([
			authorizationButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			authorizationButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			authorizationButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
			authorizationButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
		])
	}
	
	@objc func handleAuthorizationAppleIDButtonPress() {
		let appleIDProvider = ASAuthorizationAppleIDProvider()
		let request = appleIDProvider.createRequest()
		request.requestedScopes = [.fullName, .email]

		let authorizationController = ASAuthorizationController(authorizationRequests: [request])
		authorizationController.delegate = self
		authorizationController.presentationContextProvider = self
		authorizationController.performRequests()
	}
}


