// MovieDetailTableViewCell.swift
// Copyright © A.Shchukin. All rights reserved.

import UIKit

/// Ячейка деталей о фильме
final class MovieDetailTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        enum Colors {
            static let blue = "blueButton"
            static let gray = "grayForUI"
        }

        static let stringFormat = "%.1f"
        static let caveatFont = "Caveat"
        static let description = "Описание"
        static let imdb = "imdb"
        static let userMark = "Оценка пользователей: "
        static let hour = " ч. "
        static let minute = " мин. "
        static let gradient = "blackGradient"
    }

    // MARK: - Private visual elements

    private let movieTitleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 25, weight: .bold)
        return title
    }()

    private let aboutMovieLabel: UILabel = {
        let info = UILabel()
        info.textAlignment = .center
        info.font = .systemFont(ofSize: 13, weight: .medium)
        info.textColor = UIColor(named: Constants.Colors.gray)
        return info
    }()

    private let movieGenreLabel: UILabel = {
        let genre = UILabel()
        genre.font = .systemFont(ofSize: 13, weight: .medium)
        genre.textAlignment = .center
        genre.textColor = UIColor(named: Constants.Colors.gray)
        return genre
    }()

    private let markLabel: UILabel = {
        let mark = UILabel()
        mark.font = .systemFont(ofSize: 15, weight: .semibold)
        mark.textAlignment = .center
        return mark
    }()

    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let posterGradientImageView: UIImageView = {
        let gradient = UIImageView()
        gradient.image = UIImage(named: Constants.gradient)
        gradient.contentMode = .scaleAspectFill
        return gradient
    }()

    private let posterBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let overviewLabel: UILabel = {
        let overview = UILabel()
        overview.lineBreakMode = .byTruncatingHead
        overview.numberOfLines = 0
        overview.font = .systemFont(ofSize: 15)
        overview.textAlignment = .justified
        return overview
    }()

    private let taglineLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 5
        text.font = UIFont(name: Constants.caveatFont, size: 25)
        return text
    }()

    private let descriptionLabel: UILabel = {
        let text = UILabel()
        text.text = Constants.description
        text.font = .systemFont(ofSize: 30, weight: .bold)
        return text
    }()

    private let imdbButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: Constants.imdb), for: .normal)
        return button
    }()

    // MARK: - Public properties

    weak var alertDelegate: AlertDelegateProtocol?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Public methods

    func configure(index: Int, movieDetailViewModel: MovieDetailViewModelProtocol) {
        guard let movie = movieDetailViewModel.detail else { return }
        setupOverview(movie)
        setupMovieTitle(movie)
        setupImage(movie, viewModel: movieDetailViewModel)
        setupMovieRating(movie)
        setupBackgroundImage(movie, viewModel: movieDetailViewModel)
        setupAboutMovie(movie)
        setupTagline(movie)
    }

    // MARK: - Private methods

    private func setupMovieTitle(_ movie: DetailData) {
        movieTitleLabel.text = movie.title
    }

    private func setupOverview(_ movie: DetailData) {
        overviewLabel.text = movie.overview
    }

    private func setupImage(_ movie: DetailData, viewModel: MovieDetailViewModelProtocol) {
        viewModel.fetchImage(imageURLPath: movie.poster ?? "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.posterImageView.image = UIImage(data: data)
            case let .failure(error):
                self.alertDelegate?.showAlert(error: error)
            }
        }
    }

    private func setupBackgroundImage(_ movie: DetailData, viewModel: MovieDetailViewModelProtocol) {
        viewModel.fetchImage(imageURLPath: movie.backdropPath ?? "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.posterBackgroundImageView.image = UIImage(data: data)
            case let .failure(error):
                self.alertDelegate?.showAlert(error: error)
            }
        }
    }

    private func setupMovieRating(_ movie: DetailData) {
        let movieRating = "\(Constants.userMark) \(String(format: Constants.stringFormat, movie.mark))"
        markLabel.text = movieRating
    }

    private func setupAboutMovie(_ movie: DetailData) {
        aboutMovieLabel.text = "\(movie.runtime / 60) \(Constants.hour) \(movie.runtime % 60) \(Constants.minute)"
    }

    private func setupTagline(_ movie: DetailData) {
        taglineLabel.text = "\(movie.tagline ?? "")"
    }

    private func setupPosterBackgroundImageViewConstraints() {
        posterBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterBackgroundImageView)
        NSLayoutConstraint.activate([
            posterBackgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterBackgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterBackgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterBackgroundImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    private func setupPosterGradientImageViewConstraints() {
        posterGradientImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterGradientImageView)
        NSLayoutConstraint.activate([
            posterGradientImageView.bottomAnchor.constraint(equalTo: posterBackgroundImageView.bottomAnchor),
            posterGradientImageView.centerXAnchor.constraint(equalTo: posterBackgroundImageView.centerXAnchor),
            posterGradientImageView.leadingAnchor.constraint(equalTo: posterBackgroundImageView.leadingAnchor)
        ])
    }

    private func setupTaglineLabelConstraints() {
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(taglineLabel)
        NSLayoutConstraint.activate([
            taglineLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            taglineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            taglineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            taglineLabel.bottomAnchor.constraint(equalTo: posterImageView.topAnchor)
        ])
    }

    private func setupPosterImageViewConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            posterImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupMovieTitleLabelConstraints() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieTitleLabel)
        NSLayoutConstraint.activate([
            movieTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupOverviewLabelConstraints() {
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overviewLabel)
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            overviewLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }

    private func setupMarkLabelConstraints() {
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(markLabel)
        NSLayoutConstraint.activate([
            markLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            markLabel.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: 10),
            markLabel.heightAnchor.constraint(equalToConstant: 30),
            markLabel.widthAnchor.constraint(equalToConstant: 240)
        ])
    }

    private func setupAboutMovieLabelConstraints() {
        aboutMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(aboutMovieLabel)
        NSLayoutConstraint.activate([
            aboutMovieLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            aboutMovieLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: -5)
        ])
    }

    private func setupDescriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            descriptionLabel.topAnchor.constraint(equalTo: imdbButton.bottomAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }

    private func setupImdbButtonConstraints() {
        imdbButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imdbButton)
        NSLayoutConstraint.activate([
            imdbButton.centerYAnchor.constraint(equalTo: markLabel.centerYAnchor),
            imdbButton.leadingAnchor.constraint(equalTo: markLabel.trailingAnchor, constant: 5),
            imdbButton.heightAnchor.constraint(equalToConstant: 20),
            imdbButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupConstraints() {
        setupPosterBackgroundImageViewConstraints()
        setupPosterGradientImageViewConstraints()
        setupPosterImageViewConstraints()
        setupTaglineLabelConstraints()
        setupMovieTitleLabelConstraints()
        setupAboutMovieLabelConstraints()
        setupMarkLabelConstraints()
        setupImdbButtonConstraints()
        setupDescriptionLabelConstraints()
        setupOverviewLabelConstraints()
    }
}
