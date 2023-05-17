//
//  JustViewModel.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 5/9/23.
//

import SwiftUI
import Combine

class JustViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var namesToView: [String] = []
    
    func fetch() {
        let dataIn = ["Julian", "Meredith", "Luan", "Daniel", "Marina"]
        
        _ = dataIn.publisher
            .sink { [unowned self] item in
                namesToView.append(item)
            }
        
        if dataIn.count > 0 {
            Just(dataIn[0])
                .map { item in
                    item.uppercased()
                }
                .assign(to: &$name)
        }
    }
}

struct JustView: View {
    
    @StateObject var vm = JustViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(vm.name)
            Divider()
            ForEach(vm.namesToView, id: \.self) { name in
                Text(name)
            }
        }
        .font(.title)
        .onAppear {
            vm.fetch()
        }
    }
}

struct JustView_Previews: PreviewProvider {
    static var previews: some View {
        JustView()
    }
}
