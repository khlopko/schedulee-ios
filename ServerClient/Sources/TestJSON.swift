//
//  TestJSON.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

func imitateResponse(_ closure: () -> ()) {
    let deadline = DispatchTime(uptimeNanoseconds: NSEC_PER_SEC * 1000)
    DispatchQueue.main.asyncAfter(deadline: deadline, execute: closure)
}

let lessonJSON = [
    "id": 1,
    "title": "Основы магии",
    "room": "2-406",
    "lector": [
        "id": 1,
        "fullname": "Доктор Стрендж",
    ],
    "startTimestamp": 148320,
    "endTimestamp": 153720,
]
