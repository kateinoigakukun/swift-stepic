import SwiftImage
import SwiftStepicKit
import ArgumentParser

struct SwiftStepic: ParsableCommand {
    static let configuration = CommandConfiguration(
        subcommands: [Encode.self, Decode.self]
    )

    struct Encode: ParsableCommand {
        @Option() var input: String
        @Option() var output: String
        @Option() var text: String

        func run() throws {
            let textData = try String(contentsOfFile: text)
            let inputImage = Image<RGB<UInt8>>(contentsOfFile: input)!
            let outputImage = try encode(image: inputImage, text: textData)
            try outputImage.write(toFile: output, atomically: true, format: .png)
        }
    }

    struct Decode: ParsableCommand {
        @Option() var input: String
        @Option() var output: String

        func run() throws {
            let inputImage = Image<RGB<UInt8>>(contentsOfFile: input)!
            let outputText = try decode(image: inputImage)
            try outputText.write(toFile: output, atomically: true, encoding: .utf8)
        }
    }
}

SwiftStepic.main()
