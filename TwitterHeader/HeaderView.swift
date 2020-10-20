//
//  HeaderView.swift
//  TwitterHeader
//
//  Created by Omar Khodr on 10/6/20.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView =  {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Screen Shot 2020-10-06 at 8.37.42 PM"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(imageView)
        //removes automatic constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //clipping to bounds
        imageView.clipsToBounds = true
        //filling superview
        imageView.fillSuperview()
        
        //to do it without the extension:
        //anchoring each one
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: topAnchor),
//            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            imageView.leftAnchor.constraint(equalTo: leftAnchor),
//            imageView.rightAnchor.constraint(equalTo: rightAnchor),
//        ])
        
        setupGradientLayer()
        
        setupLabels()
        
        //adding blur
        setupVisualEffectBlur()
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= self.bounds.height
    }
    
    fileprivate func setupLabels() {
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Subtitle"
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 3
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    
    }
    
    var animator: UIViewPropertyAnimator!
    
    private func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: {
            let visualEffectView = UIVisualEffectView(effect: nil)
            
            self.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
            
            visualEffectView.effect = UIBlurEffect(style: .regular)
        })
        animator.fractionComplete = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//REFACTORING: Extension for faster programmatic layout

extension UIView {

    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }

    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
