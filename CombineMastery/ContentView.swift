//
//  ContentView.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 4/21/23.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var valid: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    private let imageNames = ("x.square.fill", "checkmark.square.fill")
    
    init() {
        $name
            .map({ (name) in
                return name.isEmpty
            })
            .delay(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.valid = value
            }
            .store(in: &cancellables)
            //.assign(to: &$validation)
    }
    
    func cancel() {
        cancellables.removeAll()
    }
    
    func imageName() -> String {
        return valid ? imageNames.0 : imageNames.1
    }
    
    func imageColor() -> Color {
        return valid ? .red : .green
    }
}

struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("Name", text: $vm.name)
                Image(systemName: vm.imageName())
                    .foregroundColor(vm.imageColor())
            }
            Text(vm.name)
            Spacer()
            Button("Cancel Subscription") {
                vm.cancel()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// 􀃳 􀃃
