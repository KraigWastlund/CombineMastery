//
//  TimerViewModel.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 5/9/23.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    
    @Published var interval: Double = 1
    @Published var data: [String] = []
    
    private var timerCancellable: AnyCancellable?
    private var intervalCancellable: AnyCancellable?
    
    let timeFormatter = DateFormatter()
    
    init() {
        timeFormatter.dateFormat = "HH:mm:ss.SSS"
        
        intervalCancellable = $interval
            .dropFirst()
            .sink { [unowned self] interval in
                // Restart the timer pipeline
                timerCancellable?.cancel()
                data.removeAll()
            }
    }
    
    func start() {
        timerCancellable = Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect() // auto starts the timer
            .sink { [unowned self] datum in
                data.append(timeFormatter.string(from: datum))
            }
    }
    
    func stop() {
        timerCancellable?.cancel()
    }
}

struct TimerView: View {
    @StateObject var vm = TimerViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Connect") { vm.start() }
                    .frame(maxWidth: .infinity)
                Button("Stop") { vm.stop() }
                    .frame(maxWidth: .infinity)
            }
            Slider(value: $vm.interval, in: 0.1...1, minimumValueLabel: Image(systemName: "hare"), maximumValueLabel: Image(systemName: "tortoise"), label: { Text("Interval") })
                .padding(.horizontal)
            List(vm.data, id: \.self) { datum in
                Text(datum)
                    .font(.title)
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
