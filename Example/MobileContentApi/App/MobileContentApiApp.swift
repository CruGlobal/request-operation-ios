//
//  MobileContentApiApp.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import SwiftUI

@main
struct MobileContentApiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ContentViewModel(
                    mobileContentApi: MobileContentApi(environment: .staging)
                )
            )
        }
    }
}
