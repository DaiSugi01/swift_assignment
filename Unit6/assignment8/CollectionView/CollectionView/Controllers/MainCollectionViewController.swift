//
//  MainCollectionViewController.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/04.
//

import UIKit

class MainCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    // MARK: Section Definitions 
    enum SectionType: CaseIterable {
        case header
        case movieList
    }
    
    private let SECTION_HEADER: Int = 0
    private let SECTION_MOVIE_LIST: Int = 1

    var sections = [SectionType]()
    lazy var filteredMovies: [Item] = Item.movies
    var dataSource: UICollectionViewDiffableDataSource<SectionType, Item>!
    var filteredItemSnapshot: NSDiffableDataSourceSnapshot<SectionType, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Item>()
        snapshot.appendSections([.header, .movieList])
        snapshot.appendItems(Item.categories, toSection: .header)
        snapshot.appendItems(filteredMovies, toSection: .movieList)
        
        sections = snapshot.sectionIdentifiers
        return snapshot
    }
    
    let searchController = UISearchController()
    func updateSearchResults(for searchController: UISearchController) {
        if let searchStr = searchController.searchBar.text, !searchStr.isEmpty {
            filteredMovies = Item.movies.filter { ($0.movie?.title.localizedCaseInsensitiveContains(searchStr))! }
        } else {
            filteredMovies = Item.movies
        }
        dataSource.apply(filteredItemSnapshot, animatingDifferences: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovie()
        setupNavBar()
        setupCoolectionView()
        createDataSource()
    }

    /// Set up navigation bar items
    ///
    /// - Parameters: nil
    /// - Returns: nil
    private func setupNavBar() {
        title = "Discover Movies"
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(changeLayout(_:)))
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    /// Set up collection view property
    ///
    /// - Parameters: nil
    /// - Returns: nil
    private func setupCoolectionView() {
        // setup property
        collectionView.backgroundColor = UIColor(hex: "F9F8EB")
        collectionView.allowsMultipleSelection = true
        collectionView.allowsSelection = true
        collectionView.delegate = self
        
        // Register cells
        collectionView!.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier)
        collectionView!.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier)
        
        // Register cells
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }

    /// It's called when layout button tapped to change the layout
    ///
    /// - Parameters:
    ///   - sender: The UIButtonItem element
    /// - Returns: nil
    @objc func changeLayout(_ sender: UIBarButtonItem) {
        print("tapped")
    }
    
    /// Generate copositional layouts
    ///
    /// - Parameters: nil
    /// - Returns: The Compositional layout section
    private func generateLayout() -> UICollectionViewLayout{
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.sections[sectionIndex]
            switch section {
            case .header:
                return self.createHeaderSection()
            case .movieList:
                return self.createMovieListSection()
            }
        }
    }
    
    /// Generate header section items
    ///
    /// - Parameters: nil
    /// - Returns: The customed section for the header layout
    private func createHeaderSection() -> NSCollectionLayoutSection{
        let spacing: CGFloat = 5
        
        // item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(100),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        // group
        let headerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: item.layoutSize.widthDimension,
                heightDimension: .absolute(50)
            ), subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: headerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 10, trailing: spacing)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 15
        return section
    }
    
    /// Generate movie list section items
    ///
    /// - Parameters: nil
    /// - Returns: The customed section for the movie list layout
    private func createMovieListSection() -> NSCollectionLayoutSection{
        let spacing: CGFloat = 5
        
        // item
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
                heightDimension: .fractionalHeight(1/3)
            ), subitem: innerGroup, count: 3)
        outerGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // section
        let section = NSCollectionLayoutSection(group: outerGroup)
        return section
    }
    
    /// Create data source for collection view
    ///
    /// - Parameters: nil
    /// - Returns: nil
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let sectionType = SectionType.allCases[indexPath.section]
            
            switch sectionType {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! HeaderCollectionViewCell
                cell.configureCell(with: item.genre!)
                return cell
            case .movieList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieListCollectionViewCell
                cell.configureCell(with: item.movie!)
                return cell
            }
        })
        dataSource.apply(filteredItemSnapshot)
    }
    
    /// Fetch movie discover movie list from The Movie Database API
    ///
    /// - Parameters: nil
    /// - Returns: nil
    private func fetchMovie() {
        MovieAPI.shared.fetcheMovie() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieInfo):
                    Item.movies = movieInfo.results.map {
                        if let imagepath = $0.posterPath {
                            return .movie(
                                Movie(
                                    id: $0.id,
                                    title: $0.title,
                                    overView: $0.overview,
                                    voteCount: $0.voteCount,
                                    voteAverage: $0.voteAverage,
                                    releaseDate: $0.releaseDate,
                                    genreIds: $0.genreIds,
                                    imagePath: "\(Movie.BASE_POSTER_URL)\(imagepath)"
                                )
                            )
                        } else {
                            return .movie(
                                Movie(
                                    id: $0.id,
                                    title: $0.title,
                                    overView: $0.overview,
                                    voteCount: $0.voteCount,
                                    voteAverage: $0.voteAverage,
                                    releaseDate: $0.releaseDate,
                                    genreIds: $0.genreIds,
                                    imagePath: ""
                                )
                            )
                        }
                    }
                    self.filteredMovies = Item.movies
                    self.dataSource.apply(self.filteredItemSnapshot)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == SECTION_HEADER {
            guard let selectedRows = collectionView.indexPathsForSelectedItems else { return }

            let selectedHeaderEle = selectedRows.filter{ $0[0] == 0 }

            if selectedHeaderEle.count > 0 {
                let selectedGenres = Set(selectedRows.map { Item.categories[$0.row].genre!.genreId })
                filteredMovies = Item.movies.filter {
                    let genreIds = Set($0.movie!.genreIds)
                    return genreIds.filter { selectedGenres.contains($0) }.count > 0
                }
            } else {
                filteredMovies = Item.movies
            }
            dataSource.apply(filteredItemSnapshot)
        } else if indexPath.section == SECTION_MOVIE_LIST {
            let detailVC = DetailViewController()
            detailVC.movie = filteredMovies[indexPath.row].movie
            present(detailVC, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.section == SECTION_HEADER {
            guard let selectedRows = collectionView.indexPathsForSelectedItems else { return }
            
            let selectedHeaderEle = selectedRows.filter{ $0[0] == 0 }
            
            if selectedHeaderEle.count > 0 {
                let selectedGenres = Set(selectedRows.map { Item.categories[$0.row].genre!.genreId })
                filteredMovies = Item.movies.filter {
                    let genreIds = Set($0.movie!.genreIds)
                    return genreIds.filter { selectedGenres.contains($0) }.count > 0
                }
            } else {
                filteredMovies = Item.movies
            }
            
            dataSource.apply(filteredItemSnapshot)
        }
    }
}
