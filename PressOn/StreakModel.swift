//
//
//  Created by William Sio on 7/09/25.
//

import Foundation
import SwiftUI

struct Streak {
    
    @AppStorage("streakKey") var count: Int = 0
    
    init(count: Int = 0) {
        self.count = count
    }
}
