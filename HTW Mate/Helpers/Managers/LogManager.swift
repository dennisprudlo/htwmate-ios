//
//  LogManager.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/20/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LogManager {

    public static var active: Bool = false

    public static let shared: LogManager = LogManager(ofType: .info)

    var type: LogManager.LogType
    var dump: Bool
    var notifyHost: Bool
    var delegatingInstance: Any?

    enum LogType: String, CaseIterable {
        case info = "Info"
        case warning = "Warning"
        case error = "Error"
        case dump = "Dump"
    }

    init(ofType type: LogManager.LogType, from delegatingInstance: Any? = nil, dump: Bool = false, notifyHost: Bool = false) {
        self.type = type
        self.dump = dump
        self.notifyHost = notifyHost
        self.delegatingInstance = delegatingInstance
    }

    @discardableResult func put(_ message: String) -> LogManager {
        if LogManager.active {
            dispatchMessage(message)
        }
        return self
    }

    private func dispatchMessage(_ message: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())

        let output: String = "[\(Bundle.main.displayName ?? "")] \(stretch(self.type.rawValue)) at \(dateString): \(message)"
        print(output)
    }

    private func dispatchMeta(_ message: String) {
        let output: String = "[\(Bundle.main.displayName ?? "")]                         \(stretch("›››")) \(message)"
        print(output)
    }

    func type(_ type: LogManager.LogType) -> LogManager {
        self.type = type
        return self
    }

    @discardableResult func from(_ delegatingInstance: Any) -> LogManager {
        if LogManager.active {
            self.delegatingInstance = delegatingInstance
            dispatchMeta("\(delegatingInstance)")
        }
        return self
    }

    private func stretch(_ string: String) -> String {
        var len: Int = 0
        LogManager.LogType.allCases.forEach { (type) in
            if type.rawValue.count > len {
                len = type.rawValue.count
            }
        }

        var spaces: String = ""
        let delta = len - string.count

        if delta <= 1 {
            return string
        }

        for _ in 1...(len - string.count) {
            spaces = "\(spaces) "
        }

        return "\(spaces)\(string)"
    }
}
