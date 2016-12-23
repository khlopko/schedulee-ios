//
//  Color.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public static var mainDark: UIColor { return bossanova }
    public static var secondaryDark: UIColor { return eastBay }
    public static var middle: UIColor { return zanah }
    public static var mainLight: UIColor { return doublePearlLusta }
    public static var secondaryLight: UIColor { return beige }
    
    public static var unnamed3: UIColor { return rgba(132, 169, 192) }
    public static var unnamed11: UIColor { return rgba(237, 106, 90) }
    public static var unnamed14: UIColor { return rgba(93, 87, 107) }
    
    public static var mayaBlue: UIColor { return rgba(79, 209, 255) }
    public static var dodgerBlue: UIColor { return rgba(55, 152, 242) }
    public static var midnightBlue: UIColor { return rgba(17, 21, 68) }
    public static var amber: UIColor { return rgba(255, 189, 10) }
    public static var carrotOrange: UIColor { return rgba(242, 125, 24) }
    public static var faluRed: UIColor { return rgba(101, 17, 32) }
    public static var whiteBlue: UIColor { return rgba(221, 241, 241) }
    
    public static var sulu: UIColor { return rgba(188, 231, 132) }
    public static var mediumAquamarine: UIColor { return rgba(93, 211, 158) }
    public static var scooter: UIColor { return rgba(52, 138, 167) }
    public static var eastBay: UIColor { return rgba(82, 81, 116) }
    public static var bossanova: UIColor { return rgba(81, 59, 86) }

    public static var peachPuff: UIColor { return rgba(255, 205, 178) }
    public static var roseBud: UIColor { return rgba(255, 180, 162) }
    public static var kobi: UIColor { return rgba(229, 152, 155) }
    public static var rosyBrown: UIColor { return rgba(181, 131, 141) }
    public static var dolphin: UIColor { return rgba(109, 104, 117) }

    public static var tomato: UIColor { return rgba(254, 95, 85) }
    public static var marzipan: UIColor { return rgba(240, 182, 127) }
    public static var athsSpecial: UIColor { return rgba(214, 209, 177) }
    public static var snowyMint: UIColor { return rgba(199, 239, 207) }
    public static var beige: UIColor { return rgba(238, 245, 219) }

    public static var kimberly: UIColor { return rgba(102, 106, 134) }
    public static var bermudaGrey: UIColor { return rgba(120, 138, 163) }
    public static var seaNymph: UIColor { return rgba(146, 182, 177) }
    public static var zanah: UIColor { return rgba(178, 201, 171) }
    public static var doublePearlLusta: UIColor { return rgba(232, 221, 181) }

    public static var spindle: UIColor { return rgba(167, 190, 211) }
    public static var pattensBlue: UIColor { return rgba(198, 226, 233) }
    public static var cream: UIColor { return rgba(241, 255, 196) }
    public static var peach: UIColor { return rgba(255, 202, 175) }
    public static var calico: UIColor { return rgba(218, 184, 148) }
    
    public static var unnamed1: UIColor { return rgba(221, 216, 184) }
    public static var unnamed2: UIColor { return rgba(179, 203, 185) }
    public static var unnamed4: UIColor { return rgba(106, 102, 163) }
    public static var unnamed5: UIColor { return rgba(84, 46, 113) }
    
    public static var unnamed6: UIColor { return rgba(129, 132, 121) }
    public static var unnamed7: UIColor { return rgba(181, 203, 183) }
    public static var unnamed8: UIColor { return rgba(210, 228, 196) }
    public static var unnamed9: UIColor { return rgba(228, 233, 178) }
    public static var unnamed10: UIColor { return rgba(231, 224, 139) }
    
    public static var unnamed12: UIColor { return rgba(244, 241, 187) }
    public static var unnamed13: UIColor { return rgba(155, 193, 188) }
    public static var unnamed15: UIColor { return rgba(230, 235, 224) }
}

// MARK: - Private

private func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}
