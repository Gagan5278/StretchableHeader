//
//  CollectionHeeaderReusableView.swift
//  StretchableHeader
//
//  Created by Gagan  Vishal on 6/29/20.
//

import UIKit

class CollectionHeeaderReusableView: UICollectionReusableView {
    //imageview on header
    let headerImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "headerImageView"))  //headerImageView
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //var to add blur effect
    let viualEffectViewBlur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    //Animate property on view
    var animateProperty:  UIViewPropertyAnimator!
    //MARK:- View Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        //1. Add imageview
        self.addSubview(self.headerImageView)
        self.headerImageView.fillSuperview()
        //2.
        self.addVisualEffect()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK:- Add Visual effect
    private func addVisualEffect() {
        //1.
        addSubview(self.viualEffectViewBlur)
        self.viualEffectViewBlur.fillSuperview()
        //2.
        animateProperty = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            self?.viualEffectViewBlur.effect = nil
        })
        //3.
        animateProperty.isReversed = true
        animateProperty.fractionComplete = 0.0
    }
}
