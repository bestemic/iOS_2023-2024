//
//  zadanie5App.swift
//  zadanie5
//
//  Created by Przemek Pawlik on 30/12/2023.
//

import SwiftUI
import GoogleSignIn
import FBSDKCoreKit

@main
struct zadanie5App: App {
    @StateObject var authModel = AuthModel()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .onAppear(){
                    ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }
                .environmentObject(authModel)
                .onOpenURL { url in
                    if url.scheme == "oauth-swift" {
                        GIDSignIn.sharedInstance.handle(url)
                    } else {
                        ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                    }
                }
        }
    }
}
