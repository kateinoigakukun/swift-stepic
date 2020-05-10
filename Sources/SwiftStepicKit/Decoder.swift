import Foundation
import SwiftImage

func decode(_ image: Image<RGB<UInt8>>, _ write: (UInt8) -> Void) {

    var iterator = image.makeIterator()
    while true {
        let pixels = (0..<3).flatMap { _ in iterator.next()!.bytes }
        var byte: UInt8 = 0
        
        for c in 0..<7 {
            byte |= pixels[c] & 1
            byte <<= 1
        }
        byte |= pixels[7] & 1
        write(byte)
        if let last = pixels.last, last & 1 != 0 {
            break
        }
    }
}

public func decode(image: Image<RGB<UInt8>>) throws -> String {
    var data: [UInt8] = []
    decode(image) { byte in
        data.append(byte)
    }

    let text = String(decoding: data, as: UTF8.self)
    return text
}
