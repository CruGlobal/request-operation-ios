//
//  ContentViewModel.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    private let mobileContentApi: MobileContentApi
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    @Published var language: LanguageModel?
    @Published var languages: [String] = Array()
    
    init(mobileContentApi: MobileContentApi) {
        
        self.mobileContentApi = mobileContentApi
        
        getLanguages()
        
        getLanguage()
    }
    
    private func getLanguages() {
        
        mobileContentApi
            .languageResource
            .getLanguagesEndpoint
            .getLanguages()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (languages: [LanguageModel]) in
                
                self?.languages = languages.map({
                    $0.name
                })
            }
            .store(in: &cancellables)
    }
    
    private func getLanguage() {
        
        mobileContentApi
            .languageResource
            .getLanguageEndpoint
            .getLanguage(id: "4")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (language: LanguageModel?) in
                
                self?.language = language
            }
            .store(in: &cancellables)
    }
}
