//
//  ViewController.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/07.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit



class SearchViewController: UIViewController, APIConnectorDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource
{
    
    var _searchBar: UISearchBar?
    @IBOutlet weak var _tableView: UITableView!
    
    @IBOutlet weak var _emptyStateLabel: UILabel!
    let _stack: StackOverflowAPIModel = StackOverflowAPIModel.init()
    var _selectedQuestion: StackOverflowAPIModel.Item?
    let _APIConnector: APIConnector = APIConnector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createSearchBar()
        _APIConnector.delegate = self
        _tableView.delegate = self
        _tableView.dataSource = self
        
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setNeedsUpdateConstraints()
        self.view.updateConstraints()
    }
    
    // MARK: - UISearchBar Delegate
    func createSearchBar()
    {
        _searchBar = UISearchBar()
        _searchBar?.delegate = self
        _searchBar?.tintColor = UIColor.white
        self.navigationItem.titleView = _searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        _APIConnector.getQuestions(tags: searchBar.text ?? "")
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // MARK: - TableView Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = _stack._items.count
        if(count > 0)
        {
            _emptyStateLabel.isHidden = true
        }
        else
        {
            _emptyStateLabel.isHidden = false
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QuestionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "questionCell") as! QuestionTableViewCell
        let item: StackOverflowAPIModel.Item = _stack._items[indexPath.row]
        cell._askedBy.text = "asked by " + item.owner.displayName
//        cell._isAnsweredImage
        cell._title.text = item.title.htmlToString
        cell._viewCount.text = String(format: "%d views", item.viewCount)
        cell._voteCount.text = String(format: "%d votes", item.voteCount)
        cell._answersCount.text = String(format: "%d answers", item.answerCount)
        if(item.isAnswered)
        {
            cell._isAnsweredImage.isHidden = false
            cell._titleWithImageConstraints.isActive = true
            cell._titleWithoutImageConstraints.isActive = false
        }
        else
        {
            cell._isAnsweredImage.isHidden = true
            cell._titleWithImageConstraints.isActive = false
            cell._titleWithoutImageConstraints.isActive = true
        }
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraints()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        _selectedQuestion = _stack._items[indexPath.row]
        self.performSegue(withIdentifier: "showQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let QuestionVC = navController.topViewController as! QuestionViewController
        QuestionVC._question = _selectedQuestion
        _selectedQuestion = nil;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    func loadDataOnUI(data: [String : Any]) {
        if(!_stack.extractDataFromJson(data: data))
        {
            return
        }
        DispatchQueue.main.async {
            [weak self] in
            
            if let strongSelf = self
            {
                strongSelf._tableView.reloadData()
            }
            else
            {
                return
            }
            
        }
    }
    
    
}

