//
//  PracticeEmptyPublisher.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 4/27/23.
//

import SwiftUI
import Combine

class PracticeEmptyPublisherViewModel: ObservableObject {
    
    @Published var dataToView: [String] = []
    
    init() {
        
    }
    
    func fetch() {
        
        let dataIn = ["Value 1", "Value 2", "Value 3", "BOMB", "Value 5", "Value 6"]
        
        _ = dataIn.publisher
            .filter { item in
                item != "BOMB"
            }
            .map { item in
                if item == "BOMB" {
                    return ""
                }
                return item
            }
        
        
//            .tryMap { item in
//                if item == "BOMB" {
//                    throw "Problem!!"
//                }
//
//                return item
//            }
//            .catch { (error) in
//                Empty(completeImmediately: true)
//            }
            .sink { [unowned self] (item) in
                dataToView.append(item)
            }
    }
}

struct PracticeEmptyPublisher: View {
    
    @StateObject var vm = PracticeEmptyPublisherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            List(vm.dataToView, id: \.self) { item in
                Text(item)
            }
        }
        .onAppear {
            vm.fetch()
        }
    }
}

struct PracticeEmptyPublisher_Previews: PreviewProvider {
    static var previews: some View {
        PracticeEmptyPublisher()
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
