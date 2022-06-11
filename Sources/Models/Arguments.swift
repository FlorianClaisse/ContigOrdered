//
//  File.swift
//  
//
//  Created by Florian Claisse on 01/06/2022.
//

import ArgumentParser

struct Arguments: ParsableCommand {
    @Option(help: "Chemin vers le dossier d'entrée.")
    var input: String
    
    @Option(help: "Chemin vers le dossier le sortie.")
    var output: String
}
