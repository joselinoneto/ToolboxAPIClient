//
//  AppTools.swift
//  
//
//  Created by Zé on 09/02/21.
//

import Foundation
public struct AppTools {
    public static var httpScheme: String? {
        getConfig(config.httpScheme.rawValue)
    }

    public static var httpPort: String? {
        getConfig(config.httpPort.rawValue)
    }
    
    public static var httpHost: String? {
        getConfig(config.httpHost.rawValue)
    }
}

extension AppTools {
    private enum config: String {
        case httpScheme = "HTTP_SCHEME"
        case httpPort = "HTTP_PORT"
        case httpHost = "HTTP_HOST"
    }

    private static func getConfig(_ paramName: String, _ file: String = "Info", _ fileExtension: String = "plist") -> String? {
        var nsDict: NSDictionary?
        if let path = Bundle.main.path(forResource: file, ofType: fileExtension) {
            nsDict = NSDictionary(contentsOfFile: path)
            return nsDict?[paramName] as? String
        }

        return nil
    }
}
