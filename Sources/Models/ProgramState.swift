//
//  File.swift
//  
//
//  Created by Florian Claisse on 01/06/2022.
//

import Foundation

class ProgramState {
    let intput: URL
    let output: URL
    
    init(_ input: String, _ output: String) {
        self.intput = URL(fileURLWithPath: input)
        self.output = URL(fileURLWithPath: output)
    }
    
    convenience init(_ args: Arguments) {
        self.init(args.input, args.output)
    }
    
    func strart() {
        // Check output dir
        FileManager.default.directoryExists(atPath: output, create: true)
        
        let filesURL = FileManager.default.filesURL(atPath: intput).filter { $0.pathExtension == "fasta" }
        let fastaFiles = filesURL.map { FastaFile(path: $0) }
        
        for fastaFile in fastaFiles {
            let result = fastaFile.format()
            guard let data = result.data(using: .utf8) else { fatalError("Can't encode value for file \(fastaFile.name)") }
            
            let response = FileManager.default.createFile(atPath: output.appendingPathComponent(fastaFile.name).path, contents: data)
            guard response else { fatalError("Can't create file output for \(fastaFile.name)") }
        }
    }
}
