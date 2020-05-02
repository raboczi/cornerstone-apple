//
//  UserView.swift
//  Cornerstone
//
//  Created by Simon Raboczi on 22/3/20.
//  Copyright © 2020 Simon Raboczi. All rights reserved.
//

import AuthenticationServices
import SwiftUI

struct UserView: View {
    var body: some View {
        Button("Login") {
            self.login()
        }.padding()
    }
    
    private func login() {
        print("Login")
        /*
        let controller = ASAuthorizationController(authorizationRequests: [
            ASAuthorizationAppleIDProvider().createRequest()
        ])
        controller.delegate = foo
        controller.presentationContextProvider = foo
        controller.performRequests()
        */
    }
}

/*
class Foo: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    let presentationAnchor: ASPresentationAnchor;
    
    init(presentationAnchor: ASPresentationAnchor) {
        self.presentationAnchor = presentationAnchor
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            print("AppleID login authorization")
            
        default:
            print("Fallback login authorization")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Failed logic authorization with error \(error)")
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchor;
    }
}
 */
