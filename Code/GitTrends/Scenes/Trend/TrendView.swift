//  Created on 1/17/21.

import UIKit
import Lottie

class TrendView: BaseView {
    
    @IBOutlet weak var tblView: UITableView!
    var repos: [Repo] = []
    var shouldShowShimmer = true
    
    // MARK: - Setup UI
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupRetryView()
        setupPullToRefresh()
    }
    
    private func setupTableView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(TrendingRepoCell.Nib, forCellReuseIdentifier: TrendingRepoCell.reuseIdentifier)
        tblView.register(ShimmerCell.Nib, forCellReuseIdentifier: ShimmerCell.reuseIdentifier)
        tblView.tableFooterView = UIView()
        tblView.estimatedRowHeight = 128.0
        tblView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Pull to refresh
    private func setupPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onPullToRefresh(sender:)), for: .valueChanged)
        tblView.refreshControl = refreshControl
    }
    
    @objc
    private func onPullToRefresh(sender: AnyObject) {
        getTrendsFromService()
    }
    
    // MARK: - Populate Data
    
    func reloadTable() {
        tblView.reloadData()
    }
    
    func setRepo(_ repos: [Repo]) {
        self.repos = repos
        reloadTable()
    }
    
    func showError(_ error: Error) {
        tblView.isHidden = true
        tblView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Shimmer
    
    func showShimmer() {
        shouldShowShimmer = repos.count > 0 ? false : true
        tblView.isHidden = false
        tblView.isUserInteractionEnabled = false
        reloadTable()
    }
    
    func hideShimmer() {
        shouldShowShimmer = false
        tblView.refreshControl?.endRefreshing()
        tblView.isUserInteractionEnabled = true
    }
    
    // MARK: - Service
    
    private func getTrendsFromService() {
        if let trendController = controller as? TrendController {
            trendController.getTrendsFromService()
        }
    }
    
}

extension TrendView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shouldShowShimmer ? 12 : repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !shouldShowShimmer else {
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

extension TrendView: RetryDelegate {
    // MARK: - Retry View
    private func setupRetryView() {
        if let retryView = Bundle.main.loadNibNamed("RetryView", owner: nil, options: nil)?.first as? RetryView {
            retryView.delegate = self
            retryView.frame = tblView.bounds
            addSubview(retryView)
            sendSubviewToBack(retryView)
        }
    }
    
    func onRetryAction() {
        getTrendsFromService()
    }
}
