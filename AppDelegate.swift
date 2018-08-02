//
//  AppDelegate.swift
//  MacBarButton
//
//  Created by Renan Greca on 06/07/18.
//  Copyright © 2018 renangreca. All rights reserved.
//

import Cocoa

/**
 Run arbitrary shell commands using this function.
 
 *Example:* `shell("ping", "192.168.0.1")`
 
 - warning: you must disable App Sandbox in the project settings for this to work.
 - note: Ref. [Stack Overflow](https://stackoverflow.com/questions/26971240/how-do-i-run-an-terminal-command-in-a-swift-script-e-g-xcodebuild#26973384)
 */
@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var statusButton: NSStatusBarButton!
    
    var isEnabled: Bool = true
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Aquire an NSStatusItem from the NSStatusBar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.isVisible = true
        statusItem.behavior = [.removalAllowed, .terminationOnRemoval]
        
        // Aquire a button related to the NSStatusItem
        statusButton = statusItem.button!
        
        // Configure the button's properties
        statusButton.image = #imageLiteral(resourceName: "green_circle")
        statusButton.target = self
        statusButton.action = #selector(didTapButton)
        
        // Make sure the button always starts enabled
        enable()
    }

    
    @objc func didTapButton() {
        if isEnabled {
            disable()
        } else {
            enable()
        }
    }
    
    func enable() {
        // Run anything here
        statusButton.image = #imageLiteral(resourceName: "green_circle")
        isEnabled = true
    }
    
    func disable() {
        // Run anything here
        statusButton.image = #imageLiteral(resourceName: "white_circle")
        isEnabled = false
    }

}

