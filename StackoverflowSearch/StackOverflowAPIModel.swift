//
//  StackOverflowAPIModel.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/09.
//  Copyright © 2018 Private. All rights reserved.
//

import Foundation
import UIKit

class StackOverflowAPIModel: NSObject
{
    var _hasMore: Bool
    var _quotaMax: Int
    var _quotaRemaining: Int
    
    struct Owner
    {
        var reputation: Int
        var userID: Int
        var profilePicture: String
        var displayName: String
        var linkURL: URL
        
        init() {
            reputation = 0
            userID = -1
            profilePicture = ""
            displayName = ""
            linkURL = URL(fileURLWithPath: "")
        }
    }
    
    struct Item
    {
        var tags: Array<String>
        var owner: Owner
        var isAnswered: Bool
        var viewCount: Int
        var answerCount: Int
        var voteCount: Int
        var creationDate: Date?
        var linkURL: URL
        var title: String
        var body: String
        init() {
            tags = Array<String>()
            isAnswered = false
            owner = Owner()
            viewCount = 0
            answerCount = 0
            voteCount = 0
            creationDate = nil
            linkURL = URL(fileURLWithPath: "")
            title = ""
            body = ""
        }
    }
    
    var _items:Array<Item> = Array<Item>()
    
    override init()
    {
        _hasMore = false
        _quotaMax = 0
        _quotaRemaining = 0
    }
    
    //Can be unit tested
    func fillInDataFromJSON(JSON: Dictionary<String, Any>)
    {
        _hasMore = JSON["has_more"] as! Bool
        _quotaMax = JSON["quota_max"] as! Int
        _quotaRemaining = JSON["quota_remaining"] as! Int
        
        _items = Array<Item>()
        
        let items = JSON["items"] as! Array<Dictionary<String,Any>>
        
        for item in items
        {
            var question: Item = Item()
            question.tags = item["tags"] as! Array<String>
            question.owner.displayName = (item["owner"] as! Dictionary<String, Any>)["display_name"] as! String
            question.owner.reputation = (item["owner"] as! Dictionary<String, Any>)["reputation"] as! Int
            question.owner.profilePicture = (item["owner"] as! Dictionary<String, Any>)["profile_image"] as! String
            question.owner.linkURL = URL(fileURLWithPath: (item["owner"] as! Dictionary<String, Any>)["link"] as! String)
            question.owner.userID = (item["owner"] as! Dictionary<String, Any>)["user_id"] as! Int
            question.isAnswered = item["is_answered"] as! Bool
            question.viewCount = item["view_count"] as! Int
            question.answerCount = item["answer_count"] as! Int
            question.voteCount = item["score"] as! Int
            question.creationDate = NSDate(timeIntervalSince1970: TimeInterval(item["creation_date"] as! Int)) as Date
            question.linkURL = URL(fileURLWithPath: item["link"] as! String)
            question.title = item["title"] as! String
            question.body = item["body"] as! String
            _items.append(question)
        }
    }
    
    func extractDataFromJson(data: [String: Any]) -> Bool
    {
        let isValid = JSONSerialization.isValidJSONObject(data)
        
        if(isValid)
        {
            fillInDataFromJSON(JSON: data)
            return true
        }
        else
        {
            return false
        }
    }
}
