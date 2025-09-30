import SwiftUI

enum CustomFont: String {
    case MontserratBold = "Montserrat-Bold"
    case MontserratRegular = "Montserrat-Regular"
    case MontserratSemiBold = "Montserrat-SemiBold"
    case MontserratMedium = "Montserrat-Medium"
}

extension Font {
    static func custom(_ font: CustomFont, size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> SwiftUI.Font {
        if let textStyle = textStyle {
            return SwiftUI.Font.custom(font.rawValue, size: size, relativeTo: textStyle)
        } else {
            return SwiftUI.Font.custom(font.rawValue, fixedSize: size)
        }
    }
}
