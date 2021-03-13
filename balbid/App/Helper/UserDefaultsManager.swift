//
//  UserDefaultsManager.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import Foundation
import MOLH

class UserDefaultsManager {

    private static let appLanguageKey = "appLanguage"
    private static let tokenKey = "token"
    private static let fcmTokenKey = "fcmToken"
    private static let isDarkModeKey = "isDarkMode"
    private static let selectedAddressIdKey = "selectedAddressId"

    static var appLanguage: String? {
        get {
            return UserDefaults.standard.string(forKey: appLanguageKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: appLanguageKey)
        }
    }

    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }

    static var fcmToken: String? {
        get {
            return UserDefaults.standard.string(forKey: fcmTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: fcmTokenKey)
        }
    }

    static var isDarkMode: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isDarkModeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isDarkModeKey)
        }
    }
    
    
    static var selectedAddressId: Int {
        get {
            return UserDefaults.standard.integer(forKey: selectedAddressIdKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: selectedAddressIdKey)
        }
    }

    static func removeAll() {
        token = nil
        fcmToken  = nil
        let tempIsDarkMode = isDarkMode
        let tempAppLanguage = appLanguage
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { defaults.removeObject(forKey: $0) }
        isDarkMode = tempIsDarkMode
        appLanguage = tempAppLanguage
        MOLHLanguage.setAppleLAnguageTo(appLanguage ?? Locale.current.languageCode ?? "en")
    }
}
