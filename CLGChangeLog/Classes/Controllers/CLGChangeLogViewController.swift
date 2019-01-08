//
//  CLGChangeLogViewController.swift
//  CLGChangeLog
//
//  Created by Matteo Pillon on 26/12/2018.
//  Copyright © 2018 Matteo Pillon. All rights reserved.
//

import UIKit

class CLGChangeLogViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private var changeLog : CLGChangeLog
    private let kChangeCellIdentifier = "ChangeCell"
    private var bundle : Bundle
    private var showMore = false;
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var footerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var popupViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreFooterView: UIView!
    @IBOutlet weak var changesTableView: UITableView!
    init(changelog cl: CLGChangeLog)
    {
        self.changeLog = cl
        bundle = Bundle(for: type(of: self))
        super.init(nibName: "CLGChangeLogViewController", bundle: bundle)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changesTableView.register(UINib(nibName: "CLGChangeCell", bundle: bundle ), forCellReuseIdentifier: kChangeCellIdentifier)
        popupView.layer.cornerRadius = 40;
        titleLabel.text = changeLog.title
        backgroundView.isHidden = true
        backgroundView.alpha = 0;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadAndCalculateHeight()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showBackgroundMask()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UINib(nibName: "CLGReleaseHeaderView", bundle: bundle ).instantiate(withOwner: self, options: nil)[0] as! UIView
        let label = headerView.viewWithTag(1) as! UILabel
        label.text =  "Release \(changeLog.releases[section].version)"
        return headerView
    }
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return showMore ? changeLog.releases.count
                        : min(changeLog.releases.count, 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeLog.releases[section].changes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChangeCellIdentifier, for: indexPath)
        
        let textView = cell.contentView.viewWithTag(1) as! UITextView
        textView.text = changeLog.releases[indexPath.section].changes[indexPath.row].text;
        textView.sizeToFit()
        return cell
    }
    
    // MARK: - IBActions
    @IBAction func didClosePopup(_ sender: Any) {
        backgroundView.isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundView.alpha = 0
        }) { (Bool) in
            self.backgroundView.isHidden = true
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func showMoreReleases(_ sender: Any) {
        showMore = true
        moreFooterView.isHidden = true
        footerHeightConstraint.constant = 10
        reloadAndCalculateHeight()
    }
    
    // MARK: - Private functions
    func reloadAndCalculateHeight()
    {
        changesTableView.reloadData()
        changesTableView.layoutIfNeeded()
        popupViewHeightConstraint.constant = min(changesTableView.contentSize.height + titleHeightConstraint.constant + footerHeightConstraint.constant + 20, self.view.frame.height - 100)
    }
    
    //MARK: - Public Functions
    public func showBackgroundMask()
    {
        backgroundView.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.5
        }
        
    }
    
    
}
