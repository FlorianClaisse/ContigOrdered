//
//  File.swift
//  
//
//  Created by Florian Claisse on 04/06/2022.
//

import Foundation

struct FastaFile {
    let name: String
    let contigs: [Contig]
    
    init(path: URL) {
        let content = FileManager.default.fileContent(atPath: path)
        
        var elements = content.components(separatedBy: ">")
        elements.removeFirst()
        
        let contigs = elements.map { Contig(content: $0) }
        
        self.name = path.lastPathComponent
        self.contigs = contigs
    }
    
    func format() -> String {
        var formats = [String]()
        for contig in contigs {
            formats.append(contentsOf: contig.format())
        }
        
        var result = String()
        for i in 0 ..< formats.count {
            let contig = contigNumber(i + 1)
            result.append(contentsOf: contig + "\n")
            result.append(contentsOf: formats[i] + "\n")
        }
        
        return result
    }
    
    private func contigNumber(_ i: Int) -> String {
        if (i >= 1 && i < 10) { return "Contig_000\(i)" }
        else if (i >= 10 && i < 100) { return "Contig_00\(i)" }
        else if (i >= 100 && i < 1000) { return "Contig_0\(i)" }
        else { return "Contig_\(i)" }
    }
}
