//
//  TestJSON.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Models

func imitateResponse(_ closure: () -> ()) {
    let deadline = DispatchTime(uptimeNanoseconds: NSEC_PER_SEC * 1000)
    DispatchQueue.main.asyncAfter(deadline: deadline, execute: closure)
}

let lessonJSON: JSON = [
    "id": 1,
    "title": "Введение в компьютерные науки",
    "room": "2-406",
    "lector": lectorJSON,
    "startTimestamp": 1471629273,
    "endTimestamp": 1471634673,
]

let lessonsJSON: JSON = [
    "lessons": [
        lessonJSON,
        lessonJSON,
        lessonJSON,
        lessonJSON,
    ]
]

let lectorJSON: JSON = [
    "id": 1,
    "firstname": "Максим",
    "lastname": "Мусиенко",
    "sorname": "Павлович",
]

let lectorsJSON: JSON = [
    "lectors": [
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
        lectorJSON,
    ],
]
