// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen


import UIKit.UIImage


// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public extension UIImage {
  static let animal = UIImage.bundledImage(with: "animal")
  static let info = UIImage.bundledImage(with: "info")
  static let settings = UIImage.bundledImage(with: "settings")
  static let stats = UIImage.bundledImage(with: "stats")
  static let treasure = UIImage.bundledImage(with: "treasure")
  static let camera = UIImage.bundledImage(with: "camera")
  static let foodCommon = UIImage.bundledImage(with: "food_common")
  static let foodLegendary = UIImage.bundledImage(with: "food_legendary")
  static let foodRare = UIImage.bundledImage(with: "food_rare")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

private extension UIImage {
    static func bundledImage(with name: String) -> UIImage? {
	let image = UIImage(named: name, in: .main, compatibleWith: nil) ?? UIImage(named: name)
        assert(image != nil, "Image named \(name) is missing in the bundle")
        return image
    }
}
