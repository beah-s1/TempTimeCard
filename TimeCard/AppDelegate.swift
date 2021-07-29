//
//  AppDelegate.swift
//  TimeCard
//
//  Created by Kentaro Abe on 2021/07/05.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        /*let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)*/
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        guard let button = self.statusBarItem.button else { return }
        button.image = NSImage(systemSymbolName: "checkmark.circle.fill", accessibilityDescription: nil)
        button.action = #selector(showHidePopover(_:))
        
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 350, height: 500)
        popover.behavior = .transient
        let contentView = ContentView()
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @objc func showHidePopover(_ sender: AnyObject?) {
        guard let button = self.statusBarItem.button else { return }
        if self.popover.isShown {
            self.popover.performClose(sender)
        } else {
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            self.popover.contentViewController?.view.window?.becomeKey()
        }
    }
}

