//
//  ContentView.swift
//  OXQuiz
//
//  Created by 박민우 on 1/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var num1: Int = 8
    @State private var num2: Int = 5
    @State private var res: Int = 40
    @State private var oorx: Bool = false
    @State private var questions: Double = 10 // 문제 갯수
    @State private var progress = 0.0
    @State private var finished: Bool = false
    
    @State var countCorrect: Int = 0
    @State var countWrong: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("다음 수식은 맞을까요?")
            ProgressView(value: progress)
                .padding()
            if !finished {
                Text("\(num1) x \(num2) = \(res)")
                Spacer()
                HStack {
                    Spacer()
                    Button(action: selectCorrect) {
                        Label("맞음", systemImage: "checkmark.circle")
                            .fontWeight(.bold)
                        .foregroundStyle(.green) }
                    Spacer()
                    Button(action: selectWrong) {
                        Label("틀림", systemImage: "xmark.circle")
                            .fontWeight(.bold)
                        .foregroundStyle(.red) }
                    Spacer()
                }
            }
            Spacer()
            HStack {
                Text("\(countCorrect)개 맞춤")
                Text("\t\(countWrong)개 틀림")
            }
            
            if progress >= (1.0 - 1/questions) {
                Text("준비된 문제가 모두 완료되었습니다.")
                    .foregroundStyle(.blue)
                    .font(.title2)
                    .lineLimit(1)
            } else {
                Text("")
            }
            Spacer()
            Button(action: { resetGame() }, label:  {
                Text("카운트 초기화")
            })
        }
        .font(.largeTitle)
    }
    
    func resetGame() {
        finished = false
        countCorrect = 0
        countWrong = 0
        progress = 0.0
        reloadGame()
    }
    
    func reloadGame() {
        num1 = Int.random(in: -10...10)
        num2 = Int.random(in: -10...10)
        oorx = Bool.random()
        
        oorx == true ? (res = num1 * num2) : (res = Int.random(in: -100...100))
        
        if progress >= (1.0 - 1/questions) {
            finished = true
        }
    }
    
    func selectCorrect() {
        num1 * num2 == res ? (countCorrect += 1) : (countWrong += 1)
        progress += (1.0/questions)
        reloadGame()
    }
    
    func selectWrong() {
        num1 * num2 != res ? (countCorrect += 1) : (countWrong += 1)
        progress += (1.0/questions)
        reloadGame()
    }
    
}

#Preview {
    ContentView()
}
