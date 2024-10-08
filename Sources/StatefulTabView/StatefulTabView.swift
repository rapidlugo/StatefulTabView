//
//  StatefulTabView.swift
//
//
//  Created by Nicholas Bellucci on 5/10/20.
//

import SwiftUI

public struct StatefulTabView: View {
    internal var viewControllers: [UIHostingController<AnyView>] = []
    internal var tabBarItems: [StatefulTabViewTab] = []

    internal var barTintColor: UIColor? = nil
    internal var unselectedItemTintColor: UIColor? = nil
    internal var backgroundColor: UIColor? = nil
    internal var tabBarConfiguration: StatefulTabBarBackgroundConfiguration? = nil
    
    @State private var stateIndex: Int = 0
    @Binding private var bindableIndex: Int

    private var useBindableIndex: Bool = false
    
    public init(selectedIndex: Binding<Int>? = nil, @TabBuilder _ content: () -> [StatefulTabViewTab]) {
        if let selectedIndex = selectedIndex {
            _bindableIndex = selectedIndex
            useBindableIndex = true
        } else {
            _bindableIndex = .constant(0)
            useBindableIndex = false
        }

        configureViewControllers(with: content())
    }

    public var body: some View {
        StatefulTabBarController(controllers: viewControllers,
                         tabBarItems: tabBarItems,
                         barTintColor: barTintColor,
                         unselectedItemTintColor: unselectedItemTintColor,
                         backgroundColor: backgroundColor,
                         tabBarConfiguration: tabBarConfiguration,
                         selectedIndex: useBindableIndex ? $bindableIndex : $stateIndex)
            .edgesIgnoringSafeArea(.all)
    }
}

private extension StatefulTabView {
    mutating func configureViewControllers(with tabs: [StatefulTabViewTab]) {
        tabs.forEach {
            let tabController = UIHostingController(rootView: $0.view)
            tabController.tabBarItem = $0.barItem
            tabBarItems.append($0)
            viewControllers.append(tabController)
        }
    }
}

@resultBuilder
public struct TabBuilder {
    public static func buildBlock(_ children: StatefulTabViewTab...) -> [StatefulTabViewTab] {
        children
    }

    public static func buildBlock(_ component: StatefulTabViewTab) -> [StatefulTabViewTab] {
        [component]
    }
}
