//
//  EmojiCollectionViewController.swift
//  ReplacedEmojiDictionary
//
//  Created by 杉原大貴 on 2021/02/02.
//

import UIKit

private let reuseIdentifier = "Cell"

class EmojiCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .blue
        self.collectionView!.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupNavBar()
        collectionView.backgroundColor = .white
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmoji(_:)))
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 5

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func navigateToAddEditTVC() {
        let addEditTVC = AddEditEmojiTableViewController(style: .grouped)
        addEditTVC.delegate = self
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    @objc func addNewEmoji(_ sender: UIButton) {
        navigateToAddEditTVC()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmojiCollectionViewCell
        
        cell.emojiNameLabel.text = emojis[indexPath.row].name
        cell.emojiDescriptionLabel.text = emojis[indexPath.row].description
        cell.emojiSymbolLabel.text = emojis[indexPath.row].symbol
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let addEditTVC = AddEditEmojiTableViewController(style: .grouped)
        addEditTVC.delegate = self
        addEditTVC.emoji = emojis[indexPath.row]
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            print("Editing")
        } else {
            print("not editing")
        }
    }
}

extension EmojiCollectionViewController: AddEditEmojiTVCDelegate {
    func add(_ emoji: Emoji) {
        emojis.append(emoji)
        collectionView.insertItems(at: [IndexPath(row: emojis.count - 1, section: 0)])
    }
    
    func edit(_ emoji: Emoji) {
        if let indexPath = collectionView.indexPathsForSelectedItems {
            emojis.remove(at: indexPath[0].row)
            emojis.insert(emoji, at: indexPath[0].row)
            collectionView.reloadItems(at: [indexPath[0]])
            collectionView.deselectItem(at: indexPath[0], animated: true)
        }
    }
}
