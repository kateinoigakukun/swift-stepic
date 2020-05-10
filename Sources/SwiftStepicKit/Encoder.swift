import Foundation
import SwiftImage

func encode(_ image: Image<RGB<UInt8>>, _ text: Data, _ write: (RGB<UInt8>) -> Void) {

    precondition(text.count != 0)
    precondition(text.count * 3 <= image.count)

    var iterator = image.makeIterator()

    for (i, byte) in text.enumerated() {
        var pixels = (0..<3).flatMap { _ in iterator.next()!.bytes }.map { $0 & ~1 }
        var byte = byte

        for j in (0...7).reversed() {
            pixels[j] |= byte & 1
            byte >>= 1
        }

        if i == text.endIndex - 1 {
            // write terminator
            pixels[pixels.endIndex - 1] |= 1
        }

        for i in 0..<3 {
            let offset = i * 3
            let rgb = RGB<UInt8>(red: pixels[offset], green: pixels[offset + 1], blue: pixels[offset + 2])
            write(rgb)
        }
    }
}

public func encode(image: Image<RGB<UInt8>>, text: String) throws -> Image<RGB<UInt8>> {
    var image = image

    let w = image.width
    var (x, y) = (0, 0)

    encode(image, text.data(using: .utf8)!) { pixel in
        image[x, y] = pixel
        if x == w - 1 {
            x = 0
            y += 1
        } else {
            x += 1
        }
    }
    return image
}
