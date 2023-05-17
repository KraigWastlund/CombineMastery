////
////  Future.swift
////  CombineMastery
////
////  Created by Kraig Wastlund on 4/24/23.
////
//
//import SwiftUI
//import Combine
//
//class FutureViewModel: ObservableObject {
//
//    @Published var hello: String = ""
//    @Published var goodbye: String = ""
//
//    var goodbyeCancellable: AnyCancellable?
//
//    func sayHello() {
//        Future<String, Never> { promise in
//            promise(Result.success("Hello World!!"))
//        }
//        .assign(to: &$hello)
//    }
//
//    func sayGoodbye() {
//
//    }
//}
//
//struct Future: View {
//    @StateObject private var vm = FutureViewModel()
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Say Hello") {
//                vm.sayHello()
//            }
//
//            Text(vm.hello)
//                .padding(.bottom)
//
//            Button("Say Goodbye") {
//                vm.sayGoodbye()
//            }
//
//            Text(vm.goodbye)
//
//            Spacer()
//        }
//        .font(.title)
//    }
//}
//
//struct Future_Previews: PreviewProvider {
//    static var previews: some View {
//        Future()
//    }
//}
