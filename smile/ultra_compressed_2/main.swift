import Foundation
 
var lines: [String] = []
let localPathString = "~/Repository/M38V1-A2/smile/ultra_compressed_2/"

for i in 0...35 {
    let location = NSString(string: "\(localPathString)\(i).jpg").expandingTildeInPath    
    if let data: Data = NSData(contentsOfFile: location) as Data? {
      lines.append("const uint8_t smile_\(i)[] PROGMEM = {")
      lines.append(hexTo0XPrefix(data.hexEncodedString()).joined(separator: ", "))
      lines.append("};")
    } else {
      print("location \(location) invalid")
    }
}

let source = lines.joined(separator: "\n")

do {
  try source.write(toFile: NSString(string: "\(localPathString)output.h").expandingTildeInPath, atomically: true, encoding: String.Encoding.utf8)
} catch {
  print(error)
}

//print(source)

func hexTo0XPrefix(_ bin: [String]) -> [String] {
  bin.map { bin in "0x\(bin.uppercased())" }
}

extension Data {
  func hexEncodedString() -> [String] {
    map { String(format: "%02hhx", $0) }
  }
}
