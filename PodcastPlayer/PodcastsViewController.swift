//
//  PodcastsViewController.swift
//  PodcastPlayer
//
//  Created by admin on 2/15/17.
//  Copyright © 2017 Jett Raines. All rights reserved.
//

import Cocoa

class PodcastsViewController: NSViewController {
   
    @IBOutlet weak var podcastURLTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        podcastURLTextField.stringValue = "http://www.espn.com/espnradio/podcast/feeds/itunes/podCast?id=2406595"
    }
    
    func getPodcasts() {
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
            
            let request = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            do {
            let podcasts = try context.fetch(request)
                print(podcasts)
            } catch {
                
            }
            
        }
    }
   
    @IBAction func addPodcastClicked(_ sender: Any) {
        
        if let url = URL(string: podcastURLTextField.stringValue) {
        
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error:Error?) in
            if error != nil {
                print(error.debugDescription)
            } else {
                if data != nil {
                    let parser = Parser()
                    let info = parser.getPodcastMetadata(data: data!)
                   
                    if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
                        let podcast = Podcast(context: context)
                        
                        podcast.rssURL = self.podcastURLTextField.stringValue
                        podcast.imageURL = info.imageURL
                        podcast.title = info.title
                        print("\(podcast.imageURL)")
                        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                        
                        self.getPodcasts()
                    }
                    
            }
        }
        }.resume()
            podcastURLTextField.stringValue = ""
    }
    }
}
