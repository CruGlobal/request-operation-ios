//
//  ContentView.swift
//  MobileContentApi
//
//  Created by Levi Eggert on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                    VStack(alignment: .center, spacing: 5) {
                        
                        Image(systemName: "globe")
                            .imageScale(.large)
                        
                        Text("Hello, Mobile-Content API!")
                    }
                    Spacer()
                }
                .padding([.top], 30)
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    Text("Language: \(viewModel.language?.code ?? "")")
                    Text("  name: \(viewModel.language?.name ?? "")")
                    
                }
                .padding([.top], 20)
                
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Languages: \(viewModel.languages.count)")
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 2) {
                           
                            ForEach(0 ..< viewModel.languages.count, id: \.self) { index in
                                Text("  language: \(viewModel.languages[index])")
                            }
                        }
                    }
                }
                .padding([.top], 20)
            }
        }
    }
}
