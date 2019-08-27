//
//  StarRatingView.swift
//  OpenLink
//
//  Created by William Welbes on 5/1/17.
//  Copyright © 2017 Milwaukee Tool. All rights reserved.
//

import UIKit

protocol StarRatingViewDelegate: class {
    func starRatingView(_ startRatingView: StarRatingView, didSetRatingNumber: Int)
}

class StarRatingView: UIView {

    weak var delegate: StarRatingViewDelegate?

    var stackView: UIStackView!
    var starImageViews: [UIImageView] = []
    let numberOfStars: Int = 5

    var starFullImage: UIImage!
    var starEmptyImage: UIImage!

    var currentStarRating: Int = 0

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initViews()
    }

    func initViews() {

        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear

        starFullImage = UIImage(named: "star-fill")?.withRenderingMode(.alwaysTemplate)
        starEmptyImage = UIImage(named: "star-hollow")?.withRenderingMode(.alwaysTemplate)

        for _ in 0..<numberOfStars {

            let starImageView = UIImageView(image: starEmptyImage, highlightedImage: starFullImage)
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.isUserInteractionEnabled = true
            starImageView.contentMode = .scaleAspectFit

            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapStar(sender:)))
            starImageView.addGestureRecognizer(tapGestureRecognizer)

            starImageView.addConstraint(NSLayoutConstraint(item: starImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 48.0))
            starImageView.addConstraint(NSLayoutConstraint(item: starImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 46.0))

            starImageViews.append(starImageView)
        }

        stackView = UIStackView(arrangedSubviews: starImageViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)

        let views: [String: Any] = ["stackView": stackView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackView]-0-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|", options: [], metrics: nil, views: views))
    }

    @objc func didTapStar(sender: UITapGestureRecognizer) {
        guard let starImageView = sender.view as? UIImageView,
              let index = starImageViews.index(of: starImageView) else {
            return
        }

        currentStarRating = index + 1

        delegate?.starRatingView(self, didSetRatingNumber: currentStarRating)

        updateForCurrentStarRating()
    }

    func updateForCurrentStarRating() {

        for (index, starImageView) in starImageViews.enumerated() {

            let image = index + 1 <= currentStarRating ? starFullImage : starEmptyImage

            starImageView.image = image
        }
    }
}

extension StarRatingView: DebugViewInstantiable {
    static func initView(with useCase: DebugUseCasable?) -> UIView {
        let view = StarRatingView(frame: CGRect(x: 0, y: 0, width: 300, height: 32))
        view.currentStarRating = 2
        
        return view
    }
}
