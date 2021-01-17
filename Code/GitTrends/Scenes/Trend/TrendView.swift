//  Created on 1/17/21.

import UIKit
import Lottie

class TrendView: BaseView {
    
    @IBOutlet weak var tblView: UITableView!
    let repos = Repo.getRepos()
    var isDataLoading = true {
        didSet {
            tblView.isUserInteractionEnabled = !isDataLoading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(TrendingRepoCell.Nib, forCellReuseIdentifier: TrendingRepoCell.reuseIdentifier)
        tblView.register(ShimmerCell.Nib, forCellReuseIdentifier: ShimmerCell.reuseIdentifier)
        tblView.tableFooterView = UIView()
        tblView.estimatedRowHeight = 128.0
        tblView.rowHeight = UITableView.automaticDimension
        isDataLoading = true
    }
    
}

extension TrendView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isDataLoading ? 12 : repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !isDataLoading else {
            return tableView.dequeueReusableCell(withIdentifier: ShimmerCell.reuseIdentifier)!
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingRepoCell.reuseIdentifier) as? TrendingRepoCell else {
            NSLog("TrendView: TrendingRepoCell not loaded")
            return UITableViewCell()
        }
        
        cell.setCell(repo: repos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
