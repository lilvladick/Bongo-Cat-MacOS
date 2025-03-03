import SwiftUI

class ClickManager {
    private(set) var clicks: Int
    private var timer: Timer?
    
    init() {
        self.clicks = UserDefaults.standard.integer(forKey: "clicksCount")
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(saveClicksCount), userInfo: nil, repeats: true)
    }
    
    func increment() {
        clicks += 1
    }

    @objc private func saveClicksCount() {
        UserDefaults.standard.set(clicks, forKey: "clicksCount")
        NotificationCenter.default.post(name: .clicksUpdated, object: nil)
    }
    
    deinit {
        timer?.invalidate()
        UserDefaults.standard.set(clicks, forKey: "clicksCount")
    }
}
