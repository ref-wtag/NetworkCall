
import UIKit

class ViewController: UIViewController {
    
    private let cellIdentifier = "cellPlain"
    
    var products:[Product] = []
    
    let networkManager = NetworkManager()
    

    
    @IBOutlet var table : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        networkManager.getProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                    self.table.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
       
        var value = products[indexPath.row].title
        cell.textLabel?.text = "\(value)"
        return cell
    }
    
}

extension ViewController:UITableViewDelegate {
    
}
