//
//  ViewController.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 28.06.2023.
//

import Combine
import UIKit

class PokemonsViewController: UIViewController {
    @IBOutlet var pokemonsTableView: UITableView!

    private let pokemonsViewModel = PokemonsViewModel()
    private var cancellables = Set<AnyCancellable>()

    enum Constants {
        static let pokemonsCellIdentifier = "pokemonsCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pokemonsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.pokemonsCellIdentifier)

        setupBinders()
        pokemonsViewModel.fetchPokemons()
    }

    private func setupBinders() {
        pokemonsViewModel.$pokemons
            .receive(on: RunLoop.main)
            .sink { _ in
                self.pokemonsTableView.reloadData()
            }
            .store(in: &cancellables)

        pokemonsViewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error {
                    let alert = UIAlertController(title: "Error",
                                                  message: "Could not retrieve pokemons: \(error.localizedDescription)",
                                                  preferredStyle: .alert)

                    let action = UIAlertAction(title: "OK",
                                               style: .default)
                    alert.addAction(action)
                    self?.present(alert,
                                  animated: true)
                }
            }
            .store(in: &cancellables)
    }
}

extension PokemonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsViewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = pokemonsViewModel.pokemons[indexPath.row]
        let pokemonCell = pokemonsTableView.dequeueReusableCell(withIdentifier: Constants.pokemonsCellIdentifier, for: indexPath)
        var pokemonCellDefaultConfiguration = pokemonCell.defaultContentConfiguration()
        pokemonCellDefaultConfiguration.text = pokemon.name
        pokemonCellDefaultConfiguration.secondaryText = pokemon.sprites.front_default
        pokemonCell.contentConfiguration = pokemonCellDefaultConfiguration
        return pokemonCell
    }
}

extension PokemonsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
