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
    
    public static let highball = rgba(128, 135, 60)
    
    public static let lasPalmas = rgba(204, 217, 62)
    
    public static let splashBackground = rgba(158, 167, 56)
    public static let splashLine = lasPalmas
    
    public static let white = rgba(255, 255, 255)
    
    public static let mayaBlue = rgba(79, 209, 255)
    public static let dodgerBlue = rgba(55, 152, 242)
    public static let midnightBlue = rgba(17, 21, 68)
    public static let amber = rgba(255, 189, 10)
    public static let carrotOrange = rgba(242, 125, 24)
    public static let faluRed = rgba(101, 17, 32)
    public static let whiteBlue = rgba(221, 241, 241)
    
    /*
     public static let main1 = rgba(188, 231, 132) Sulu (LightGreen)
     public static let main2 = rgba(93, 211, 158) Medium Aquamarine
     public static let main3 = rgba(52, 138, 167) Scooter (Dark Aquamarine)
     public static let main4 = rgba(82, 81, 116) East Bay (Dark Gray-Violette)
     public static let main5 = rgba(81, 59, 86) Bossanova (Dark Chocollate Red)
     */
    /*
     public static let main1 = rgba(255, 205, 178) Peach Puff
     public static let main2 = rgba(255, 180, 162) Rose Bud
     public static let main3 = rgba(229, 152, 155) Kobi
     public static let main4 = rgba(181, 131, 141) Rosy Brown
     public static let main5 = rgba(109, 104, 117) Dolphin
     */
    /*
     public static let main1 = rgba(254, 95, 85) Tomato
     public static let main2 = rgba(240, 182, 127) Marzipan
     public static let main3 = rgba(214, 209, 177) Aths Special
     public static let main4 = rgba(199, 239, 207) Snowy Mint
     public static let main5 = rgba(238, 245, 219) Beige
     */
    /*
     public static let main1 = rgba(102, 106, 134) Kimberly
     public static let main2 = rgba(120, 138, 163) Bermuda Grey
     public static let main3 = rgba(146, 182, 177) Sea Nymph
     public static let main4 = rgba(178, 201, 171) Zanah
     public static let main5 = rgba(232, 221, 181) Double Pearl Lusta
     */
    /*
     public static let main1 = rgba(167, 190, 211) Spindle
     public static let main2 = rgba(198, 226, 233) Pattens Blue
     public static let main3 = rgba(241, 255, 196) Cream
     public static let main4 = rgba(255, 202, 175) Peach
     public static let main5 = rgba(218, 184, 148) Calico
     */
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
}

private func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}
