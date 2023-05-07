
import UIKit


// MARK: - Color

class Colors {
    
    
    
    // MARK: - RGBA
    
    class func rgba( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    class func rgb( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return rgba(red, green, blue, 1)
    }
    
    // MARK: - Gray
    
    class func grayLevel(_ gray: CGFloat) -> UIColor {
        return rgb(gray, gray, gray)
    }
    
    class func blackAlpha(_ alpha: CGFloat) -> UIColor {
        return rgba(0, 0, 0, alpha)
    }
    
    // MARK: - Custom Colors Properties
    
    static public let lightGray = blackAlpha(0.1)
    static public let slightlyDark = blackAlpha(0.3)
    static public let halfBlack = blackAlpha(0.5)
    
    static public let black = grayLevel(0) // 0 %
    static public let gray = grayLevel(127) // 49 %
    static public let lightInactiveGray = grayLevel(178) // 69 %
    static public let silver = grayLevel(229) // 89 %
    static public let inactiveGray = grayLevel(246) // 96 %
    static public let white = grayLevel(255) // 100 %
    
    static public let transparentGray = rgba(225, 225, 225, 0.3)
    static public let lightOrange = rgba(255, 105, 0, 0.1)
    
    static public let red = rgb(255, 59, 48)
    static public let blue = rgb(44, 174, 233)
    static public let yellow = rgb(254, 219, 6)
    static public let orange = rgb(255, 105, 0)
    static public let purple = rgb(128, 0, 128)
    static public let gold = rgb(226, 201, 127)
    static public let beige = rgb(245, 245, 220)
    static public let brand = rgb(255, 105, 0)
    static public let approveGreen = rgb(49, 183, 0)
    static public let darkBlue = rgb(74, 144, 226)
    static public let semidarkBlue = rgb(0, 107, 202)
    static public let darkGray = rgb(142, 142, 147)
    static public let lightYellow = rgb(254, 229, 6)
    
}




// MARK: - Extension UIColor

extension UIColor {
    
    
    
    
    // MARK: - RGBA | Values
    
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
    
    // MARK: RGBA | Tuples
    
    func rgbaValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    // MARK: - Hex | UIColor -> String
    
    func hex() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgba:Int = (Int)(a*255)<<24 | (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        let rgbaStr = String(format:"#%08x", rgba)
        
//        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
//        let str = String(format:"#%06x", rgb)

        return rgbaStr
    }
    
    // MARK: Hex | String -> Color
    
    public convenience init?(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var color: UIColor? = nil
        
        if ((cString.count) != 6) {
            color = .gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        color = UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        
        guard let c = color else { return nil }
        let v = c.rgbaValues()
        self.init(red: v.red, green: v.green, blue: v.blue, alpha: v.alpha)
        return
    }
    
  
    // MARK: Hex | String -> Color (Old)
    
    public convenience init?(old hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
    
  
}

