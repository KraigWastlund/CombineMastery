//
//  PracticeThursday.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 4/27/23.
//

import SwiftUI
import Combine

class PracticeThursdayViewModel: ObservableObject {
    @Published var tryCancelling: String = ""
    @Published var isValid: Bool = true
    var cancellables: [AnyCancellable] = []
    
    init() {
        startListening()
    }
    
    func startListening() {
        $tryCancelling
            .map { newValue -> Bool in
                if newValue == "Bob" {
                    return false
                }
                
                return true
            }
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                self.isValid = value
            })
            .store(in: &cancellables)
    }
    
    func stopListening() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
}

struct PracticeCancelAndResume: View {
    @StateObject var vm = PracticeThursdayViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter Something", text: $vm.tryCancelling)
            Text("Is Valid")
                .foregroundColor(vm.isValid ? .black : .red)
            
            Text(vm.tryCancelling)
            
            Button("Cancel Subscription") {
                vm.stopListening()
            }
            
            Button("Resume Subscription") {
                vm.startListening()
            }
        }
    }
}

struct PracticeThursday_Previews: PreviewProvider {
    static var previews: some View {
        PracticeCancelAndResume()
    }
}
