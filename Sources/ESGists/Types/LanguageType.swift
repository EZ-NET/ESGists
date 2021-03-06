//
//  LanguageType.swift
//  ESGists
//
//  Created by Tomohiro Kumagai on H27/08/04.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

public protocol LanguageType : CaseIterable, Hashable, RawRepresentable, CustomStringConvertible {
	
	var extname: String { get }
	var language: Language { get }
}

extension LanguageType {
    
    public var hashValue:Int {
        
        description.hashValue
    }
}

extension LanguageType {
    
    public init?(displayText: String) {
        
        guard let found = Self.allCases.first(where: { $0.description == displayText }) else {
            
            return nil
        }
        
        self = found
    }
}

extension LanguageType {
	
	public var description: RawValue {
		
		rawValue
	}
}

extension Sequence where Element : LanguageType {
	
	public var languages: [Language] {
	
		map(Language.init)
	}
	
	@discardableResult
	public func sort() -> [Element] {

		sorted {
			
			$0.description.lowercased() < $1.description.lowercased()
		}
	}
}

extension Set where Element : LanguageType {
	
	public var languages: Set<Language> {
		
		Set<Language>(map(Language.init))
	}
}
