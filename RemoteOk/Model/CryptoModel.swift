//
//  CryptoModel.swift
//
//  Created by Hoff Henry Pereira da Silva on 18/04/2018
//  Copyright (c) . All rights reserved.
//

import Foundation

public class CryptoModel: Codable {
    
	public var id : String?
	public var jobTitle : String?
	public var jobDescription : String?
	public var jobLocation : String?
	public var salaryRange : String?
	public var companyAbout : String?
	public var companyName : String?
	public var companyLogo : String?
	public var bossPicture : String?
	public var remote : Bool?
	public var publishedAt : String?
	public var bitlyLink : String?
	public var canonicalURL : String?


    
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
		jobTitle = dictionary["jobTitle"] as? String
		jobDescription = dictionary["jobDescription"] as? String
		jobLocation = dictionary["jobLocation"] as? String
		salaryRange = dictionary["salaryRange"] as? String
		companyAbout = dictionary["companyAbout"] as? String
		companyName = dictionary["companyName"] as? String
		companyLogo = dictionary["companyLogo"] as? String
		bossPicture = dictionary["bossPicture"] as? String
		remote = dictionary["remote"] as? Bool
		publishedAt = dictionary["publishedAt"] as? String
		bitlyLink = dictionary["bitlyLink"] as? String
		canonicalURL = dictionary["canonicalURL"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.jobTitle, forKey: "jobTitle")
		dictionary.setValue(self.jobDescription, forKey: "jobDescription")
		dictionary.setValue(self.jobLocation, forKey: "jobLocation")
		dictionary.setValue(self.salaryRange, forKey: "salaryRange")
		dictionary.setValue(self.companyAbout, forKey: "companyAbout")
		dictionary.setValue(self.companyName, forKey: "companyName")
		dictionary.setValue(self.companyLogo, forKey: "companyLogo")
		dictionary.setValue(self.bossPicture, forKey: "bossPicture")
		dictionary.setValue(self.remote, forKey: "remote")
		dictionary.setValue(self.publishedAt, forKey: "publishedAt")
		dictionary.setValue(self.bitlyLink, forKey: "bitlyLink")
		dictionary.setValue(self.canonicalURL, forKey: "canonicalURL")

		return dictionary
	}

}
