//
//  CurrentValueSubject.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 4/24/23.
//

import SwiftUI
import Combine

class CurrentValueSubjectViewModel: ObservableObject {
    @Published var selection = "No Name Selected"
    var selectionSame = CurrentValueSubject<Bool, Never>(false)
    var cancellables: [AnyCancellable] = []
    
    init() {
        $selection
            .map { [weak self] newValue -> Bool in
                guard let self else { return false }
                return newValue == self.selection
            }
            .sink { [weak self] value in
                guard let self else { return }
                self.selectionSame.value = value
                objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}

struct CurrentValueSubject: View {
    @StateObject private var vm = CurrentValueSubjectViewModel()
    var body: some View {
        
        VStack(spacing: 20) {
            Button("Select Lorenzo") {
                vm.selection = "Lorenzo"
            }
            
            Button("Select Ellen") {
                vm.selection = "Ellen"
            }
            
            Text(vm.selection)
                .foregroundColor(vm.selectionSame.value ? .red : .green)
        }
        .font(.title)
    }
}

struct CurrentValueSubject_Previews: PreviewProvider {
    static var previews: some View {
        CurrentValueSubject()
    }
}
