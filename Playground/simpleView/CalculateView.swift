//
//  CalculateView.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/17.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent, decimal

    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .ac: return "AC"
        case .plusMinus: return "±"
        case .percent: return "%"
        case .decimal: return "."
        }
    }

    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return Color(.orange)
        }
    }
}

struct CalculateView: View {
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals],
    ]

    let divider = CGFloat(10)

    @State var currentInput = "0"
    @State var storedInput = ""
    @State var currentOperation: CalculatorButton?

    var body: some View {
        VStack(spacing: divider) {
            Spacer()
            HStack {
                Spacer()
                Text(currentInput)
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            .padding()

            ForEach(buttons, id: \.self) { row in
                HStack(spacing: divider) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button: button)
                        }) {
                            Text(button.title)
                                .font(.system(size: 32))
                                .frame(width: buttonWidth(button: button), height: buttonHeight())
                                .background(button.backgroundColor)
                                .foregroundColor(.white)
                                .cornerRadius(buttonWidth(button: button)/2)
                        }
                    }
                }
            }
        }
        .background(.black)
    }

    func buttonWidth(button: CalculatorButton) -> CGFloat {
        let standarWidth = (UIScreen.main.bounds.width) / 4 - divider
        if button == .zero {
            return standarWidth * 2 + divider
        }
        return standarWidth
    }

    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width) / 4 - divider
    }

    func buttonTapped(button: CalculatorButton) {
        switch button {
        case .ac:
            currentInput = "0"
            storedInput = ""
        case .plusMinus:
            if currentInput.first == "-" {
                currentInput.removeFirst()
            } else {
                currentInput = "-" + currentInput
            }
        case .percent:
            if let value = Double(currentInput) {
                currentInput = String(value / 100)
            }
        case .decimal:
            if !currentInput.contains(".") {
                currentInput += "."
            }
        case .plus, .minus, .multiply, .divide:
            storedInput = currentInput
            currentInput = "0"
            currentOperation = button
        case .equals:
            if let operation = currentOperation {
                let inputValue = Double(currentInput) ?? 0
                let storedValue = Double(storedInput) ?? 0
                switch operation {
                case .plus:
                    currentInput = String(storedValue + inputValue)
                case .minus:
                    currentInput = String(storedValue - inputValue)
                case .multiply:
                    currentInput = String(storedValue * inputValue)
                case .divide:
                    currentInput = String(storedValue / inputValue)
                default:
                    break
                }
            }
        default:
            if currentInput == "0" {
                currentInput = button.title
            } else {
                currentInput += button.title
            }
        }
    }
}

struct CalculateView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateView()
    }
}
