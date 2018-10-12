//
//  QuestionViewController.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/09.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var _title: UILabel!
    @IBOutlet weak var _body: UITextView!
    @IBOutlet weak var _displayName: UILabel!
    @IBOutlet weak var _reputation: UILabel!
    @IBOutlet weak var _creationDate: UILabel!
    @IBOutlet weak var _profilePicture: UIImageView!
    
    @IBOutlet weak var _footerView: UIView!
    @IBOutlet weak var _tag: UILabel!
    var _question: StackOverflowAPIModel.Item?
    let _dateTools = DateTools.init()
    let stringPlaceHolderName = "placeholder"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _title.text = _question?.title.htmlToString
        _body.attributedText = _question?.body.htmlToAttributedString
        _displayName.text = _question?.owner.displayName
        _reputation.text = String(format: "%d", (_question?.owner.reputation)!)
        _creationDate.text = _dateTools.convertDateToString(date: (_question?.creationDate)!)
        _profilePicture.imageFromServerURL((_question?.owner.profilePicture)!, placeHolder: UIImage(named: stringPlaceHolderName))
        _tag.addBorders(edges: [.top], color: .gray)
        _footerView.addBorders(edges: [.top], color: .gray)
        _title.addBorders(edges: [.bottom], color: .gray)
        var tagString: String = ""
        for tag in (_question?.tags ?? Array<String>())
        {
            tagString.append(" " + tag + ",")
        }
        tagString = tagString.trimmingCharacters(in: CharacterSet(charactersIn: " ,"))
        _tag.text = tagString
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }

}
