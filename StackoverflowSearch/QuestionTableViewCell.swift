//
//  QuestionTableViewCell.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/09.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var _isAnsweredImage: UIImageView!
    
    @IBOutlet weak var _title: UILabel!
    @IBOutlet weak var _askedBy: UILabel!
    @IBOutlet weak var _voteCount: UILabel!
    @IBOutlet weak var _answersCount: UILabel!
    @IBOutlet weak var _viewCount: UILabel!
    @IBOutlet weak var _titleWithoutImageConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var _mainContent: UIView!
    @IBOutlet weak var _titleWithImageConstraints: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _mainContent.addBorders(edges: [.bottom,.top], color: UIColor.darkGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
