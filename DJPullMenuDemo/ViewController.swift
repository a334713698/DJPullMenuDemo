//
//  ViewController.swift
//  DJPullMenuDemo
//
//  Created by fcn on 2020/10/12.
//

import UIKit


class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var beginDragOffsetY: CGFloat = 0.0
    var isOpen = false
    
    
    // prama MARK - Property
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableView.Style.grouped)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets.zero
        if UIDevice.current.systemVersion.compare("11.0", options: .numeric, range: nil, locale: nil) != .orderedAscending {
            tableView.estimatedSectionHeaderHeight = 10
            tableView.estimatedSectionFooterHeight = 0.01
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let mj_header = MJRefreshHeader.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        mj_header.setRefreshingTarget(self, refreshingAction: #selector(loadHeaderView))
        mj_header.backgroundColor = .yellow
        mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_header = mj_header

        var lab = UILabel.init(frame: mj_header.frame)
        mj_header.addSubview(lab)
        lab.text = "hello, world"
        lab.textAlignment = .center

        return tableView
    }()
    
    @objc func loadHeaderView() {
        print("hello")
    }
    
    // prama MARK - VC life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.isHidden = false
    }
    
    // prama MARK - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    // prama MARK - UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    // prama MARK - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NSLog("开始拖拽")
//        NSLog("%lf", scrollView.contentOffset.y)
        beginDragOffsetY = scrollView.contentOffset.y
    }

    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        NSLog("已经放手")
//        NSLog("%lf", scrollView.contentOffset.y)
        if scrollView.contentOffset.y < beginDragOffsetY {
            self.tableView.mj_header!.beginRefreshing()
            self.isOpen = true
        }else{
            self.tableView.mj_header!.endRefreshing()
            self.isOpen = false
        }
        self.tabBarController?.tabBar.isHidden = self.isOpen
    }
    
}

