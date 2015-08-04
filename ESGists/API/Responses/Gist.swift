//
//  Gist.swift
//  ESGist
//
//  Created by Tomohiro Kumagai on H27/07/20.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import Himotoki

public struct Gist {

	public var id:String
	public var description:String
	public var publicGist:Bool
	public var owner:GistUser?
	public var user:String?
	public var files:[String:Gist.GistFileInfo]
	public var commentCount:Int
	public var timestamp:Gist.Timestamp
	public var urls:Gist.URLs
}

extension Gist {

	public struct URLs {
		
		public var url:URL
		public var forksUrl:URL
		public var commitsUrl:URL
		public var commentUrl:URL
		public var htmlUrl:URL
		public var gitPullUrl:URL
		public var gitPushUrl:URL
	}
	
	public struct GistFileInfo {
		
		public var size:Int
		public var rawUrl:URL
		public var type:String
		public var truncated:Bool
		public var language:Language?
	}
	
	public struct CommentStatus {
		
		public var count:Int
		public var url:URL
	}
	
	public struct Timestamp {
		
		public var createdAt:Date
		public var updatedAt:Date
	}
}

extension Gist : Decodable {
	
	public static func decode(e: Extractor) -> Gist? {
		
		return build(
		
			e <| "id",
			e <| "description",
			e <| "public",
			e <| "owner",
			e <|? "user",
			e <|-| "files",
			e <| "comments",
			Gist.Timestamp.decode(e),
			Gist.URLs.decode(e)
			
		).map(Gist.init)
	}
}

extension Gist.GistFileInfo : Decodable {

	public static func decode(e: Extractor) -> Gist.GistFileInfo? {

		return build(
		
			e <| "size",
			e <| "raw_url",
			e <| "type",
			e <| "truncated",
			e <|? "language"
		
		).map(Gist.GistFileInfo.init)
	}
}

extension Gist.URLs : Decodable {

	public static func decode(e: Extractor) -> Gist.URLs? {
		
		return build(
		
			e <| "url",
			e <| "forks_url",
			e <| "commits_url",
			e <| "comments_url",
			e <| "html_url",
			e <| "git_pull_url",
			e <| "git_push_url"
		
		).map(Gist.URLs.init)
	}
}

extension Gist.Timestamp : Decodable {
	
	public static func decode(e: Extractor) -> Gist.Timestamp? {
		
		return build(
			
			e <| "updated_at",
			e <| "created_at"
			
			).map(Gist.Timestamp.init)
	}
}

extension Gist.Timestamp : CustomStringConvertible {
	
	public var description:String {
		
		return String(self.updatedAt)
	}
}

extension Gist.Timestamp : CustomDebugStringConvertible {
	
	public var debugDescription:String {
		
		return "{ Updated at \(self.updatedAt), Created at \(self.createdAt) }"
	}
}
