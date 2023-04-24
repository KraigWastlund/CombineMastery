//
//  PublishedView.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 4/24/23.
//

import SwiftUI

class Published_IntroductionViewModel: ObservableObject {
    var characterLimit = 30
    @Published var data = ""
    @Published var charactercount = 0
    @Published var countcolor = Color.gray
    
    init() {
        $data
            .map { data in
                return data.count
            }
            .assign(to: &$charactercount)
        $charactercount
            .map { [weak self] count in
                guard let self else { return .gray }
                let eightyPercent = Int(Double(self.characterLimit) * 0.8)
                if (eightyPercent...self.characterLimit).contains(count) {
                    return .yellow
                } else if count > self.characterLimit {
                    return .red
                } else {
                    return .gray
                }
            }
            .assign(to: &$countcolor)
    }
}

struct PublishedView: View {
    @StateObject private var vm = Published_IntroductionViewModel()
    var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $vm.data)
                .border(Color.gray, width: 1)
                .frame(height: 200)
                .padding()
            Text("\(vm.charactercount)/\(vm.characterLimit)")
                .foregroundColor(vm.countcolor)
        }
    }
}

struct PublishedView_Previews: PreviewProvider {
    static var previews: some View {
        PublishedView()
    }
}
