//
//  MainCollectionViewController.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/04.
//

import UIKit

private let reuseIdentifier = "HeaderCell"
private let musicReuseIdentifier = "MusicCell"

class MainCollectionViewController: UICollectionViewController {
    
    let musics = [
        Music(songName: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", artistName: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",genre: "Pop", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "bbb", artistName: "BBB", genre: "Rock", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "ccc", artistName: "CCC", genre: "Country", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "ddd", artistName: "DDD", genre: "Folk", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "eee", artistName: "EEE", genre: "Hip Hop", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "fff", artistName: "FFF", genre: "Jazz", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "ggg", artistName: "GGG", genre: "Blues", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "hhh", artistName: "HHH", genre: "Classical", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "iii", artistName: "III", genre: "Electronic", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        Music(songName: "jjj", artistName: "JJJ", genre: "Heavy metal", imageName: "https://images.yourstory.com/cs/7/4c455a90a21411e98b07315772315642/Untitleddesign67-1597919456187.png"),
        
        Music(songName: "kkk", artistName: "KKK", genre: "Pop", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "lll", artistName: "LLL", genre: "Rock", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "mmm", artistName: "MMM", genre: "Country", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "nnn", artistName: "NNN", genre: "Folk", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "ooo", artistName: "OOO", genre: "Hip Hop", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "ppp", artistName: "PPP", genre: "Jazz", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "qqq", artistName: "QQQ", genre: "Blues", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "rrr", artistName: "RRR", genre: "Classical", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "sss", artistName: "SSS", genre: "Electronic", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg"),
        Music(songName: "ttt", artistName: "TTT", genre: "Heavy metal", imageName: "https://i.ytimg.com/vi/FtIE7juUBdo/maxresdefault.jpg")
    ]
    
    var genres = [
        Music(songName: "", artistName: "",genre: "Pop", imageName: ""),
        Music(songName: "", artistName: "", genre: "Rock", imageName: ""),
        Music(songName: "", artistName: "", genre: "Country", imageName: ""),
        Music(songName: "", artistName: "",genre: "Folk", imageName: ""),
        Music(songName: "", artistName: "", genre: "Hip Hop", imageName: ""),
        Music(songName: "", artistName: "", genre: "Jazz", imageName: ""),
        Music(songName: "", artistName: "",genre: "Blues", imageName: ""),
        Music(songName: "", artistName: "", genre: "Classical", imageName: "")
    ].sorted(by: >)
      
    lazy var filteredMusics: [Music] = self.musics

    lazy var musicsByGenre: [String: [Music]] = self.filteredMusics.reduce([:]) { (exsisting, element) in
        return exsisting.merging([element.genre: [element]]) { (old, new) in
            return old + new
        }
    }
    lazy var musicGenres: [String] = musicsByGenre.keys.sorted()
    var dataSource: UICollectionViewDiffableDataSource<SectionType, Music>!
    var filteredItemSnapshot: NSDiffableDataSourceSnapshot<SectionType, Music> {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Music>()
        
        snapshot.appendSections([.header, .musicList])
        snapshot.appendItems(genres, toSection: .header)
        snapshot.appendItems(filteredMusics, toSection: .musicList)
        return snapshot
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        title = "My Musics"
        
        collectionView.allowsMultipleSelection = true
        collectionView.allowsSelection = true
        
        collectionView.delegate = self
        collectionView!.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.register(MusicListCollectionViewCell.self, forCellWithReuseIdentifier: musicReuseIdentifier)
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        createDataSource()
    }
    
    private func generateLayout() -> UICollectionViewLayout{
        
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let layoutType = SectionType.allCases[sectionIndex]
            switch layoutType {
            case .header:
                return self.createHeaderSection()
            case .musicList:
                return self.createMusicListSection()
            }
        }
    }
    
    private func createHeaderSection() -> NSCollectionLayoutSection{
        let spacing: CGFloat = 5
        
        // item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/4),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        // group
        let headerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)
            ), subitems: [item, item])
        headerGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        // section
        let section = NSCollectionLayoutSection(group: headerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createMusicListSection() -> NSCollectionLayoutSection{
        let spacing: CGFloat = 5
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        // inner group
        let innerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ), subitem: item, count: 1)
        innerGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        // outer group
        let outerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1/5)
            ), subitem: innerGroup, count: 2)
        outerGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        // section
        let section = NSCollectionLayoutSection(group: outerGroup)
        return section
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, Music>(collectionView: collectionView, cellProvider: { [self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            let sectionType = SectionType.allCases[indexPath.section]
            
            switch sectionType {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeaderCollectionViewCell
                cell.genreLabel.text = genres[indexPath.row].genre
                cell.layer.cornerRadius = 10
                return cell
            case .musicList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: musicReuseIdentifier, for: indexPath) as! MusicListCollectionViewCell
                if self.filteredMusics[indexPath.row].imageName.isEmpty {
                    cell.image.image = UIImage(named: "noimage")
                } else {
                    cell.image.image = UIImage(url: filteredMusics[indexPath.row].imageName)
                }
                cell.songNameLabel.text = self.filteredMusics[indexPath.row].songName
                cell.artistNameLabel.text = self.filteredMusics[indexPath.row].artistName
                cell.layer.cornerRadius = 10
                return cell
            }
        })
        dataSource.apply(filteredItemSnapshot)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedRows = collectionView.indexPathsForSelectedItems else { return }
        if selectedRows.count > 0 {
            let selectedGenres = selectedRows.map { genres[$0.row].genre }
            filteredMusics = musics.filter { selectedGenres.contains($0.genre) }
        } else {
            filteredMusics = musics
        }
        dataSource.apply(filteredItemSnapshot)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let selectedRows = collectionView.indexPathsForSelectedItems else { return }
        
        if selectedRows.count > 0 {
            filteredMusics = filteredMusics.filter { return genres[indexPath.row].genre != $0.genre  }
        } else {
            filteredMusics = musics
        }
        dataSource.apply(filteredItemSnapshot)
    }
}

enum SectionType: CaseIterable {
    case header
    case musicList
}
