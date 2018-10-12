//
//  StackoverflowSearchTests.swift
//  StackoverflowSearchTests
//
//  Created by Josue on 2018/10/07.
//  Copyright © 2018 Private. All rights reserved.
//

import XCTest
@testable import StackoverflowSearch

class StackoverflowSearchTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testfillInDataFromJSON()
    {
        let _stack: StackOverflowAPIModel = StackOverflowAPIModel.init()
        
        let data: [String: Any] =
            [
            "items": [
                [
                    "tags": [
                        "ios",
                        "swift"
                    ],
                    "owner": [
                        "reputation": 339,
                        "user_id": 3711916,
                        "user_type": "registered",
                        "accept_rate": 83,
                        "profile_image": "https://www.gravatar.com/avatar/2a7fa2dccecb5691698bf6781dd932c3?s=128&d=identicon&r=PG&f=1",
                        "display_name": "Gary",
                        "link": "https://stackoverflow.com/users/3711916/gary"
                    ],
                    "is_answered": true,
                    "view_count": 120463,
                    "accepted_answer_id": 24065036,
                    "answer_count": 10,
                    "score": 61,
                    "last_activity_date": 1539076217,
                    "creation_date": 1401983542,
                    "last_edit_date": 1501158794,
                    "question_id": 24064740,
                    "link": "https://stackoverflow.com/questions/24064740/create-a-button-programmatically-and-set-a-background-image",
                    "title": "Create a button programmatically and set a background image",
                    "body": "<p>When I try creating a button and setting a background image in Swift:</p>\n\n<pre><code>let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton\n    button.frame = CGRectMake(100, 100, 100, 100)\n    button.setImage(IMAGE, forState: UIControlState.Normal)\n    button.addTarget(self, action: \"btnTouched:\", forControlEvents: UIControlEvents.TouchUpInside)\n\n    self.view.addSubview(button)\n</code></pre>\n\n<p>I always get an error: \"<strong>Cannot convert the expression's type 'Void' to type 'UIImage'</strong>\".</p>\n"
                ]
            ],
            "has_more": true,
            "quota_max": 10000,
            "quota_remaining": 9993
        ]
        
        XCTAssertTrue(_stack.extractDataFromJson(data: data))
        XCTAssertTrue(_stack._items.count == 1)
        if (_stack._items.count>0)
        {
            let item: StackOverflowAPIModel.Item = _stack._items[0]
            let date: Date = NSDate(timeIntervalSince1970: TimeInterval(1401983542)) as Date
            XCTAssertTrue(item.creationDate == date)
            XCTAssertTrue(item.owner.userID == 3711916)
        }
    }
    
    func testconvertDateToString()
    {
        //Bad test. Specific to Timezone +2 only.
        let epoch = 1401983542
        let date: Date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        let dateTools = DateTools.init()
        let dateString = dateTools.convertDateToString(date: date)
        
        let expectedResult: String = "asked 5th June 2014 at 17:52"
//        NSLog("TEST:\nresult:\t%@\nExpect. res.:%@", dateString, expectedResult)
        XCTAssertTrue(dateString.elementsEqual(expectedResult))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
