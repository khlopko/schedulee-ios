//
//  Color.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

public struct Color {
    
    public static let clear = UIColor.clear
    
    public static let white = rgba(255, 255, 255)
    
    public static let mayaBlue = rgba(79, 209, 255)
    public static let dodgerBlue = rgba(55, 152, 242)
    public static let midnightBlue = rgba(17, 21, 68)
    public static let amber = rgba(255, 189, 10)
    public static let carrotOrange = rgba(242, 125, 24)
    public static let faluRed = rgba(101, 17, 32)
    public static let whiteBlue = rgba(221, 241, 241)
    
    public static let sulu = rgba(188, 231, 132)
    public static let mediumAquamarine = rgba(93, 211, 158)
    public static let scooter = rgba(52, 138, 167)
    public static let eastBay = rgba(82, 81, 116)
    public static let bossanova = rgba(81, 59, 86)

    public static let peachPuff = rgba(255, 205, 178)
    public static let roseBud = rgba(255, 180, 162)
    public static let kobi = rgba(229, 152, 155)
    public static let rosyBrown = rgba(181, 131, 141)
    public static let dolphin = rgba(109, 104, 117)

    public static let tomato = rgba(254, 95, 85)
    public static let marzipan = rgba(240, 182, 127)
    public static let athsSpecial = rgba(214, 209, 177)
    public static let snowyMint = rgba(199, 239, 207)
    public static let beige = rgba(238, 245, 219)

    public static let kimberly = rgba(102, 106, 134)
    public static let bermudaGrey = rgba(120, 138, 163)
    public static let seaNymph = rgba(146, 182, 177)
    public static let zanah = rgba(178, 201, 171)
    public static let doublePearlLusta = rgba(232, 221, 181)

    public static let spindle = rgba(167, 190, 211)
    public static let pattensBlue = rgba(198, 226, 233)
    public static let cream = rgba(241, 255, 196)
    public static let peach = rgba(255, 202, 175)
    public static let calico = rgba(218, 184, 148)
    
    public static var allColors: [UIColor] {
         return [
            mayaBlue, dodgerBlue, midnightBlue, amber, carrotOrange, faluRed, whiteBlue, sulu,
            mediumAquamarine, scooter, eastBay, bossanova, peachPuff, roseBud, kobi, rosyBrown,
            dolphin, tomato, marzipan, athsSpecial, snowyMint, beige, kimberly, bermudaGrey,
            seaNymph, zanah, doublePearlLusta, spindle, pattensBlue, cream, peach, calico,
        ]
    }
}

private func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}

/*
 public static let main1 = rgba(221, 216, 184)
 public static let main2 = rgba(179, 203, 185)
 public static let main3 = rgba(132, 169, 192)
 public static let main4 = rgba(106, 102, 163)
 public static let main5 = rgba(84, 46, 113)
 */
/*
 public static let main1 = rgba(129, 132, 121)
 public static let main2 = rgba(181, 203, 183)
 public static let main3 = rgba(210, 228, 196)
 public static let main4 = rgba(228, 233, 178)
 public static let main5 = rgba(231, 224, 139)
 */
/*
 public static let main1 = rgba(237, 106, 90)
 public static let main2 = rgba(244, 241, 187)
 public static let main3 = rgba(155, 193, 188)
 public static let main4 = rgba(93, 87, 107)
 public static let main5 = rgba(230, 235, 224)
 */

