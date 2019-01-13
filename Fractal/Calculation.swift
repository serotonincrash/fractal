//
//  Calculation.swift
//  Fractal
//
//  Created by Sean on 28/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import Foundation

class Calculation: Encodable, Decodable {
    var calc: String
    var result: String
    init(calc: String, result: String) {
        self.calc = calc
        self.result = result
    }
    static func getArchiveURL() -> URL {
        let plistName = "calculations"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(calcs: [Calculation]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedCalcs = try? propertyListEncoder.encode(calcs)
        try? encodedCalcs?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Calculation]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedCalcsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedCalcs = try? propertyListDecoder.decode(Array<Calculation>.self, from: retrievedCalcsData) else { return nil }
        return decodedCalcs
    }
    
}
