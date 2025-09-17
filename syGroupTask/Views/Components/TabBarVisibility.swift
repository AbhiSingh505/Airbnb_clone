import SwiftUI

struct TabBarVisibilityKey: PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value || nextValue()
    }
}

extension View {
    func tabBarHidden(_ hidden: Bool) -> some View {
        self.preference(key: TabBarVisibilityKey.self, value: hidden)
    }
}

