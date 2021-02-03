//
//  EmojiCollectionViewCell.swift
//  ReplacedEmojiDictionary
//
//  Created by 杉原大貴 on 2021/02/02.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
        
    let emojiSymbolLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        return lb
    }()
    
    let emojiNameLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()

    let emojiDescriptionLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        let vStackView = VerticalStackView(arrangedSubviews: [
            emojiNameLabel,
            emojiDescriptionLabel
        ], spacing: 0, alignment: .fill, distribution: .fill)
        
        let hStackView = HorizontalStackView(arrangedSubviews: [
            emojiSymbolLabel, vStackView
        ], spacing: 16, alignment: .fill, distribution: .fill)
        
        contentView.addSubview(hStackView)
        hStackView.matchParent(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
}
