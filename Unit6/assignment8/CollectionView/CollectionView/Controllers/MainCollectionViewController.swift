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
    
    // MARK: Music List Section Layout Definitions
    var activeLayout: Layout = .grid {
        didSet {
            collectionView.setCollectionViewLayout(generateLayout(), animated: true) { (_) in
                switch self.activeLayout {
                case .grid:
                    self.layoutButton.image = UIImage(systemName: "rectangle.grid.1x2")
                case .column:
                    self.layoutButton.image = UIImage(systemName: "square.grid.2x2")
                }
            }
            collectionView.contentOffset.y = 0
            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListGridCollectionViewCell.gridReuseIdentifier, for: indexPath) as! MovieListGridCollectionViewCell
            
        }
    }
    
    var layout: [Layout: NSCollectionLayoutSection] = [:]
    var layoutButton = UIBarButtonItem()

    // MARK: Datasource and Snapshot
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
    
    // MARK: SearchController Definitions
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
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(hex: "101C28")
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(hex: "DEE8EE")
        ]
        layoutButton = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.grid.1x2"),
            style: .done,
            target: self,
            action: #selector(changeLayout(_:))
        )
        navigationItem.rightBarButtonItem = layoutButton
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    /// Set up collection view property
    ///
    /// - Parameters: nil
    /// - Returns: nil
    private func setupCoolectionView() {
        // setup property
        collectionView.backgroundColor = UIColor(hex: "132937")
        collectionView.allowsMultipleSelection = true
        collectionView.allowsSelection = true
        collectionView.delegate = self
        
        // Register cells
        collectionView!.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier)
        collectionView!.register(MovieListGridCollectionViewCell.self, forCellWithReuseIdentifier: MovieListGridCollectionViewCell.reuseIdentifier)

        // movie list section layout
        self.layout[.grid] = self.generateMovieGridLayout()
        self.layout[.column] = self.generateColumnLayout()

        // generate layout
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
    }
    
    /// It's called when layout button tapped to change the layout
    ///
    /// - Parameters:
    ///   - sender: The UIButtonItem element
    /// - Returns: nil
    @objc func changeLayout(_ sender: UIBarButtonItem) {
        switch activeLayout {
        case .grid:
            activeLayout = .column
        case .column:
            activeLayout = .grid
        }
    }
    
    /// Generate copositional layouts
    ///
    /// - Parameters: nil
    /// - Returns: The Compositional layout section
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                        
            let section = self.sections[sectionIndex]
            switch section {
            case .header:
                return self.generateHeaderLayout()
            case .movieList:
                return self.layout[self.activeLayout]
            }
        }
    }
    
    /// Generate header section items
    ///
    /// - Parameters: nil
    /// - Returns: The customed section for the header layout
    private func generateHeaderLayout() -> NSCollectionLayoutSection{
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
        headerGroup.contentInsets = .init(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        // section
        let section = NSCollectionLayoutSection(group: headerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 10, bottom: 10, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 15
        return section
    }
    
    /// Generate movie section for grid layout
    ///
    /// - Parameters: nil
    /// - Returns: The customed section for the movie list layout
    private func generateMovieGridLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 5
        
        // item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        // group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(300)
            ), subitem: item, count: 3)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        return section
    }
    
    /// Generate movie section for column layout
    ///
    /// - Parameters: nil
    /// - Returns: The customed section for the movie list layout
    private func generateColumnLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 20
        
        let item = NSCollectionLayoutItem(
            layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .fractionalHeight(1)
                )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .fractionalHeight(1/3)
                ),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        return section
    }
    
    /// Create data source for collection view
    ///
    /// - Parameters: nil
    /// - Returns: nil
    private func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<SectionType, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let sectionType = self.sections[indexPath.section]
            
            switch sectionType {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! HeaderCollectionViewCell
                cell.configureCell(with: item.genre!)
                return cell
            case .movieList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListGridCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieListGridCollectionViewCell
                switch self.activeLayout {
                case .grid:
                    cell.configureGridCell(with: item.movie!)
                case .column:
                    cell.configureColumnCell(with: item.movie!)
                }
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
                        if let posterImagepath = $0.posterPath, let backdropImagepath = $0.backdropPath {
                            return .movie(
                                Movie(
                                    id: $0.id,
                                    title: $0.title,
                                    overView: $0.overview,
                                    voteCount: $0.voteCount,
                                    voteAverage: $0.voteAverage,
                                    releaseDate: $0.releaseDate,
                                    genreIds: $0.genreIds,
                                    posterImagePath: "\(Movie.BASE_POSTER_URL)\(posterImagepath)",
                                    backdropPath: "\(Movie.BASE_POSTER_URL)\(backdropImagepath)"
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
                                    posterImagePath: "",
                                    backdropPath: ""
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
}

// MARK: UICollectionViewDelegate
extension MainCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == SECTION_HEADER {
            updateFilterMovies()
        } else if indexPath.section == SECTION_MOVIE_LIST {
            let detailVC = DetailViewController()
            detailVC.movie = filteredMovies[indexPath.row].movie
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.section == SECTION_HEADER {
            updateFilterMovies()
        }
    }
    
    private func updateFilterMovies() {
        guard let selectedRows = collectionView.indexPathsForSelectedItems else { return }
        
        let selectedHeaderEle = selectedRows.filter{ $0[0] == 0 }
        
        if selectedHeaderEle.count > 0 {
            let selectedGenres = Set(selectedRows.map { Item.categories[$0.row].genre!.genreId })
            
            if let searchStr = searchController.searchBar.text, !searchStr.isEmpty {
                filteredMovies = Item.movies.filter { ($0.movie?.title.localizedCaseInsensitiveContains(searchStr))! }
            } else {
                filteredMovies = Item.movies
            }

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

enum Layout {
    case grid
    case column
}
