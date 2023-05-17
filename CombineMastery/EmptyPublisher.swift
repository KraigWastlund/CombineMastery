//
//  EmptyPublisher.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 4/24/23.
//

import SwiftUI
import Combine

struct BombDetectedError: Error { }

class Empty_IntroViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    
    func fetch() {
        let dataIn = ["Value1", "Value2", "Value3", "Value4", "**BOMB**", "Value6"]
        
        _ = dataIn.publisher
            .tryMap { item in
                if item == "**BOMB**" {
                    throw BombDetectedError()
                }
                
                return item
            }
            .catch { (error) in
                Empty(completeImmediately: true)
            }
            .sink { [weak self] (item) in
                guard let self else { return }
                self.dataToView.append(item)
            }
    }
}

struct EmptyPublisher: View {
    @StateObject private var vm = Empty_IntroViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            List(vm.dataToView, id: \.self) { item in
                Text(item)
            }
        }
        .font(.title)
        .onAppear {
            vm.fetch()
        }
    }
}

struct EmptyPublisher_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPublisher()
    }
}
