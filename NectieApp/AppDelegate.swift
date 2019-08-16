//
//  AppDelegate.swift
//  NectieApp
//
//  Created by Art Krahenbuhl on 8/16/19.
//  Copyright © 2019 necktieapp. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var eventMonitor: EventMonitor?

    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off..."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) - \(quoteAuthor)")
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Necktie", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("Necktie"))
            button.action = #selector(printQuote(_:))
        }
        constructMenu()
        
        // Init an event monitor
        eventMonitor = EventMonitor(mask: [.keyDown]) { [weak self]
        event in
            if let strongSelf = self {
                strongSelf.printQuote(event)
            }
        }        
        eventMonitor?.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        if eventMonitor != nil {
            eventMonitor?.stop()
        }
    }


}

