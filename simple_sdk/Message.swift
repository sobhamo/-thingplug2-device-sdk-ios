//
//  Message.swift
//  simple_sdk
//
//  Created by JONGILKIM on 2017. 11. 23..
//  Copyright © 2017년 JONGILKIM. All rights reserved.
//

public class Message {
    
    //MARK: Properties
    public var topic: String
    public var subscribedMessage: String
    
    //MARK: Initialization
    init?(topic: String, subscribedMessage: String) {
        
        // Initialize stored properties.
        self.topic = topic
        self.subscribedMessage = subscribedMessage
    }
}
