//
//  SegmnetsViewController.swift
//  Streamer
//
//  Created by Varmtech on 2/5/19.
//  Copyright © 2019 Varmtech. All rights reserved.
//

import UIKit

class SegmnetsViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private let segmentCell = "SegmentCell"
    var segments: [Segment] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        segmetsRequest()
        setupNavBar()
        segmetsRequest()
    }
    
    // MARK: Setups
    func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // MARK: - Server request
    func segmetsRequest() {
        let form = SegmentsForm(f: "test")
        SegmetService.shered.segmentsResponse(data: form) { (segmetsResponseData) in
            switch segmetsResponseData {
            case .base(response: let baseResposne):
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
            case .success(let segmentsData):
                guard let segmentsTmp = segmentsData[0].segments else { return }
                self.segments = segmentsTmp
            case .isOffline:
                return
            }
             DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

extension SegmnetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return segments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segments[section].steps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: segmentCell, for: indexPath) as? SegmentCell
        cell?.steps = segments[indexPath.section].steps?[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

extension SegmnetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // TODO: - Header View
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        let label = UILabel()
        label.text =  segments[section].title
        label.textColor = UIColor.white
        label.frame = CGRect(x: 25, y: -5, width: 100, height: 35)
        
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame = CGRect(x: 260, y: 0, width: 90, height: 28)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.8
        button.layer.cornerRadius = 6
       
        view.addSubview(label)
        view.addSubview(button)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

