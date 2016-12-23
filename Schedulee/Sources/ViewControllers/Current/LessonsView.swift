//
//  LessonsView.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/19/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

final class LessonsView: UIView {

    let collection = LessonsView.makeCollection()
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .unnamed15
        indicator.hidesWhenStopped = true
        addSubview(collection)
        collection.addSubview(indicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collection.frame = bounds
        indicator.frame = collection.frame
    }
    
    private static func makeCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.allowsMultipleSelection = false
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.bounces = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }
}
