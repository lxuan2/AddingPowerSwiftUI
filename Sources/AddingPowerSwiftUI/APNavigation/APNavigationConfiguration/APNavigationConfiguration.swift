//
//  APNavigationConfiguration.swift
//  
//
//

import SwiftUI

// MARK: - APNavigationBackButtonTitleKey

public struct APNavigationBackButtonTitleKey: PreferenceKey {
    public typealias Value = String?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationBackButtonTitle(_ title: String?) -> some View {
        transformPreference(APNavigationBackButtonTitleKey.self) { value in
            APNavigationBackButtonTitleKey.reduce(value: &value, nextValue: { title })
        }
    }
}

// MARK: - APNavigationBackButtonDisplayModeKey
public struct APNavigationBackButtonDisplayModeKey: PreferenceKey {
    public typealias Value = APNavigationBarItem.BackButtonDisplayMode?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationBackButtonDisplayMode(_ displayMode: APNavigationBarItem.BackButtonDisplayMode) -> some View {
        transformPreference(APNavigationBackButtonDisplayModeKey.self) { value in
            APNavigationBackButtonDisplayModeKey.reduce(value: &value, nextValue: { displayMode })
        }
    }
}

// MARK: - APNavigationTitleDisplayModeKey

public struct APNavigationTitleDisplayModeKey: PreferenceKey {
    public typealias Value = APNavigationBarItem.TitleDisplayMode?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationBarTitleDisplayMode(_ displayMode: APNavigationBarItem.TitleDisplayMode) -> some View {
        transformPreference(APNavigationTitleDisplayModeKey.self) { value in
            APNavigationTitleDisplayModeKey.reduce(value: &value, nextValue: { displayMode })
        }
    }
}

// MARK: - APNavigationBarBackButtonHiddenKey

public struct APNavigationBarBackButtonHiddenKey: PreferenceKey {
    public typealias Value = Bool?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationBarBackButtonHidden(_ hidesBackButton: Bool?) -> some View {
        transformPreference(APNavigationBarBackButtonHiddenKey.self) { value in
            APNavigationBarBackButtonHiddenKey.reduce(value: &value, nextValue: { hidesBackButton })
        }
    }
}

// MARK: - APNavigationBarHiddenKey

public struct APNavigationBarHiddenKey: PreferenceKey {
    public typealias Value = Bool?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationBarHidden(_ hidden: Bool?) -> some View {
        transformPreference(APNavigationBarHiddenKey.self) { value in
            APNavigationBarHiddenKey.reduce(value: &value, nextValue: { hidden })
        }
    }
}

// MARK: - APNavigationLeftItemsSupplementBackButtonKey

public struct APNavigationLeftItemsSupplementBackButtonKey: PreferenceKey {
    public typealias Value = Bool?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationLeftItemsSupplementBackButton(_ isSupplement: Bool?) -> some View {
        transformPreference(APNavigationLeftItemsSupplementBackButtonKey.self) { value in
            APNavigationLeftItemsSupplementBackButtonKey.reduce(value: &value, nextValue: { isSupplement })
        }
    }
}

// MARK: - APNavigationPromptKey

public struct APNavigationPromptKey: PreferenceKey {
    public typealias Value = String?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationPrompt(_ prompt: String?) -> some View {
        transformPreference(APNavigationPromptKey.self) { value in
            APNavigationPromptKey.reduce(value: &value, nextValue: { prompt })
        }
    }
}

// MARK: - APNavigationTitleKey

public struct APNavigationTitleKey: PreferenceKey {
    public typealias Value = String?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

extension View {
    public func apNavigationTitle(_ title: String?) -> some View {
        transformPreference(APNavigationTitleKey.self) { value in
            APNavigationTitleKey.reduce(value: &value, nextValue: { title })
        }
    }
}
