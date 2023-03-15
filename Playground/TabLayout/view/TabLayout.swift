//
//  TabLayout.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/15.
//

import SwiftUI

struct TabLayoutView: View {
    @State var alignment: TextAlignment = .leading

    var body: some View {
        VStack(spacing: 0) {
            picker()
            tabLayout()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.blue)
    }

    // MARK: makeItemView
    @ViewBuilder
    fileprivate func makeItemView(_ text: String) -> some View {
        Text(text)
            .font(.title2.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.white.opacity(0.9))
            .cornerRadius(6)
            .id(text)
    }

    // MARK: makePicker
    fileprivate func picker() -> some View {
        return Picker("", selection: $alignment) {
            Text("leading")
                .tag(TextAlignment.leading)
            Text("center").tag(TextAlignment.center)
            Text("traling").tag(TextAlignment.trailing)
        }
        .pickerStyle(.segmented)
        .padding()
        .background(Color.purple)
    }

    // MARK: makeTabLayout
    @ViewBuilder
    fileprivate func tabLayout() -> some View {
        TabLayout(alignment: alignment) {
            makeItemView("11")
            makeItemView("22222")
            makeItemView("3333")
            makeItemView("444")
            makeItemView("555")
            makeItemView("66")
            makeItemView("77")
            makeItemView("88888")
            makeItemView("99999")
            makeItemView("10")
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(alignment: .topLeading)
        .padding()
        .animation(.easeInOut, value: alignment)
    }
}

// MARK: TabLayout
struct TabLayout: Layout {
    var vSpacing: CGFloat = 10
    var alignment: TextAlignment = .trailing

    struct Row {
        var viewRects: [CGRect] = []

        var width: CGFloat { viewRects.last?.maxX ?? 0 }
        var height: CGFloat { viewRects.map(\.height).max() ?? 0 }

        func getStartX(in bounds: CGRect, alignment: TextAlignment) -> CGFloat {
            switch alignment {
            case .leading:
                return bounds.minX
            case .center:
                return bounds.minX + (bounds.width - width) / 2
            case .trailing:
                return bounds.maxX - width
            }
        }
    }

    func getRows(proposalWidth: CGFloat, subViews: Subviews) -> [Row] {
        guard !subViews.isEmpty else { return [] }

        var rows = [Row()]

        subViews.indices.forEach { index in
            let preView = rows.last!.viewRects.isEmpty ? nil : subViews[index - 1]
            let view = subViews[index]
            let proposol = ProposedViewSize(width: proposalWidth, height: nil)

            let viewSize = view.sizeThatFits(proposol)
            let preViewRect = rows.last!.viewRects.last ?? .zero
            // 两个view之间的spacing
            let spacing = preView?.spacing.distance(to: view.spacing, along: .horizontal) ?? 0

            // 超出一行
            if preViewRect.maxX + viewSize.width + spacing > proposalWidth {
                let rect = CGRect(origin: .init(x: 0, y: preViewRect.minY + rows.last!.height + vSpacing), size: viewSize)
                let row = Row(viewRects: [rect])
                rows.append(row)
            }
            // 未超出一行
            else {
                let rect = CGRect(origin: .init(x: preViewRect.maxX + spacing, y: preViewRect.minY), size: viewSize)
                rows[rows.count - 1].viewRects.append(rect)
            }
        }

        return rows
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = getRows(proposalWidth: proposal.width ?? 0, subViews: subviews)

//        return CGSize(width: rows.map(\.width).max() ?? 0,
//                      height: rows.last?.viewRects.map(\.maxY).max() ?? 0)
        return CGSize(width: proposal.width ?? 0,
                      height: rows.last?.viewRects.map(\.maxY).max() ?? 0)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = getRows(proposalWidth: bounds.width, subViews: subviews)

        var index = 0
        rows.forEach { row in

            let startX = row.getStartX(in: bounds, alignment: alignment)
            row.viewRects.forEach { rect in
                let view = subviews[index]
                defer { index += 1 }

                view.place(at: .init(x: startX + rect.minX, y: bounds.minY + rect.minY),
                           proposal: .init(rect.size))
            }
        }
    }
}

struct TabLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        TabLayoutView()
    }
}
