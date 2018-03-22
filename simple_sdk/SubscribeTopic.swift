//
//  SubscribeTopic.swift
//  simple_sdk
//
//  Created by JONGILKIM on 2017. 11. 23..
//  Copyright © 2017년 JONGILKIM. All rights reserved.
//

public class SubscribeTopic {
    
    //MARK: Properties
    public var topicText: String
    public var isSubscribed: Bool
    
    //MARK: Initialization
    public init(_ topicText: String) {
        self.topicText = topicText
        self.isSubscribed = false
        
        _console("SubscribeTopic init self.topicText : \(self.topicText )")
        _console("SubscribeTopic init self.isSubscribed : \(self.isSubscribed )")
    }
    
}
