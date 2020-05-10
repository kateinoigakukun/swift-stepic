import SwiftImage

extension RGB where Channel == UInt8 {
    var bytes: [UInt8] { [red, green, blue] }
}
