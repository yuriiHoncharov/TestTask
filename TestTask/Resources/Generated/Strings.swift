// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Description:
  internal static func description() -> String { 
    return L10n.tr("Localizable", "Description") 
  }
  /// Favourite
  internal static func favourite() -> String { 
    return L10n.tr("Localizable", "Favourite") 
  }
  /// Home
  internal static func home() -> String { 
    return L10n.tr("Localizable", "Home") 
  }
  /// MOVIE to G
  internal static func movieToG() -> String { 
    return L10n.tr("Localizable", "MovieToG") 
  }
  /// Release:
  internal static func release() -> String { 
    return L10n.tr("Localizable", "Release") 
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let localeID = getLocalizationLanguage().localeIdentifier
    if let path = BundleToken.bundle.path(forResource: localeID, ofType: "lproj"), let bundle = Bundle(path: path) {
        let localizedStr = NSLocalizedString(key, tableName: table, bundle: bundle, value: "", comment: "")
        return String(format: localizedStr, args)
    }
    return NSLocalizedString(key, tableName: table, bundle: BundleToken.bundle, value: "", comment: "")
  }

  private static func getLocalizationLanguage() -> Language {
    if let language = LanguageManager.shared.getCurrentLanguage() {
        return language
    } else {
        let language = Language(languageCode: Locale.current.languageCode)
        LanguageManager.shared.setLanguage(language)
        return language
    }
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
