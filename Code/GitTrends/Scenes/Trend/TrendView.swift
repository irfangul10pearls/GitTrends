//  Created on 1/17/21.

import UIKit

class TrendView: BaseView {
    
    @IBOutlet weak var tblView: UITableView!
    let repos = Repo.getRepos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(TrendingRepoCell.Nib, forCellReuseIdentifier: TrendingRepoCell.reuseIdentifier)
        tblView.tableFooterView = UIView()
        tblView.estimatedRowHeight = 128.0
        tblView.rowHeight = UITableView.automaticDimension
    }
    
}

extension TrendView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
