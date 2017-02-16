//
//  Parser.swift
//  PodcastPlayer
//
//  Created by admin on 2/15/17.
//  Copyright © 2017 Jett Raines. All rights reserved.
//

import Foundation

class Parser {
    
    func getPodcastMetadata(data: Data) -> (title: String?, imageURL: String?) {
        
        let xml = SWXMLHash.parse(data)
        
        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
        
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
            
        
        
    }
    
}
