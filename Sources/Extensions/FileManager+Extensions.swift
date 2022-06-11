//
//  File.swift
//  
//
//  Created by Florian Claisse on 01/06/2022.
//

import Foundation


extension FileManager {
    
    @discardableResult
    func directoryExists(atPath path: URL, create: Bool) -> Bool {
        if !self.fileExists(atPath: path.path) {
            if create { try! self.createDirectory(at: path, withIntermediateDirectories: true) }
            return false
        }
        
        return true
    }
    
    func filesURL(atPath path: URL) -> [URL] {
        do {
            let directoryContent = try self.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            let result = directoryContent.filter { $0.pathExtension != "" }
            return result
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /*func filesContent(atPath paths: [URL]) -> [String] {
        var result = [String]()
        
        for path in paths {
            result.append(self.fileContent(atPath: path))
        }
        
        return result
    }*/
    
    func fileContent(atPath path: URL) -> String {
        guard let data = self.contents(atPath: path.path) else { fatalError("Can't load data from file \(path)") }
        let string = String(decoding: data, as: UTF8.self)
        
        return string
    }
}
