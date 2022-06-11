//
//  File.swift
//  
//
//  Created by Florian Claisse on 04/06/2022.
//

struct Contig {
    let name: String
    let chain: String
    
    init(content: String) {
        guard let firstIndex = content.firstIndex(of: "\n") else { fatalError("Can(t decode file") }
        let start = content.startIndex
        
        let name = content[start..<firstIndex]
        
        var chain = content[firstIndex..<content.endIndex]
        chain.removeAll { $0 == "\n" }
        
        self.name = String(name)
        self.chain = String(chain)
    }
    
    func format() -> [String] {
        var arrays = [String]()
        var value = String()
        var add = true
        
        for element in self.chain {
            if (element == "N") {
                if (add) {
                    arrays.append(value)
                    add = false
                    value.removeAll()
                }
            } else {
                add = true
                value.append(element)
            }
        }
        
        if (value != "") { arrays.append(value) }
        
        return arrays
    }
}

extension Contig: CustomStringConvertible {
    var description: String {
        return "Contig(name: \(name), chain: \(chain)"
    }
}
