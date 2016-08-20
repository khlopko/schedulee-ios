//
//  LessonsView.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/19/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

class LessonsView: UIView {

    let collection = LessonsView.makeCollection()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.white
        all.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collection.frame = bounds
    }
}

private extension LessonsView {

    var all: [UIView] {
        return [collection]
    }
}

private extension LessonsView {
    
    static func makeCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout() ->> {
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
            $0.scrollDirection = .horizontal
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout) ->> {
            $0.allowsMultipleSelection = false
            $0.backgroundColor = Color.clear
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
    }
}
