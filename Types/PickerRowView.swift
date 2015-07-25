//
//  PickerRowView.swift
//  Types
//
//  Created by Andrew Clissold on 7/25/15.
//  Copyright (c) 2015 Andrew Clissold. All rights reserved.
//

import UIKit

class PickerRowView: UIView {

    private var titleLabel: UILabel!

    private let viewHeight: CGFloat = 200
    private let viewWidth: CGFloat = 140
    private let labelHeight: CGFloat = 20
    private let marginSize: CGFloat = 10

    init(title: String, image: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))

        var y = (bounds.size.height - labelHeight) / 2
        titleLabel = UILabel(frame: CGRect(
            x: marginSize + image.size.width,
            y: y,
            width: frame.size.width + image.size.width,
            height: labelHeight))
        titleLabel.text = title
        titleLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
        titleLabel.backgroundColor = UIColor.clearColor()
        addSubview(titleLabel)

        y = (bounds.size.height - image.size.height) / 2
        let imageView = UIImageView(frame: CGRect(x: marginSize, y: y, width: image.size.width, height: image.size.height))
        imageView.image = image
        addSubview(imageView)

        isAccessibilityElement = true
        accessibilityLabel = title
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
