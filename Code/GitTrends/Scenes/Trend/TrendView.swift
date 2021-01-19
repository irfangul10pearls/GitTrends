//  Created on 1/17/21.

import UIKit
import Lottie

class TrendView: BaseView {
    
    @IBOutlet weak var tblView: UITableView!
    var repos: [Repo] = []
    var isDataLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    private func setupUI() {
        setupTableView()
        loadRetryView()
    }
    
    // MARK: - Retry View
    private func loadRetryView() {
        if let retryView = Bundle.main.loadNibNamed("RetryView", owner: nil, options: nil)?.first as? RetryView {
            retryView.delegate = self
            retryView.frame = tblView.bounds
            addSubview(retryView)
            sendSubviewToBack(retryView)
        }
    }
    
    // MARK: - Pull to refresh
    
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
    }
    
    // MARK: - Shimmer
    
    func showShimmer() {
        isDataLoading = true
        tblView.isHidden = false
        tblView.isUserInteractionEnabled = false
    }
    
    func hideShimmer() {
        isDataLoading = false
        tblView.isUserInteractionEnabled = true
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

extension TrendView: RetryDelegate {
    func onRetryAction() {
        if let trendController = controller as? TrendController {
            trendController.getTrendsFromService()
        }
    }
}
