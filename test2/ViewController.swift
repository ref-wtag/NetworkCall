
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var table : UITableView!
    
    @IBAction func buttonClick(_ sender : UIButton){
        // let urlString = "https://api.sunrise-sunset.org/json?date=%202020-01-01&lat=-74.0060&lng=40.7128&formatted=0"
         
         let urlString = "https://fakestoreapi.com/products"
         fetchApiData(with : urlString)
          sender.isHidden = true
    }
    
    
    var apiData : [[ String : Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    func fetchApiData(with url : String){
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else{
                return
            }
            
           
            //for objects -----------------------------------
           // guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String : Any] else { return  }
            // print("\(jsonObject)")
          //let newData = jsonObject["results"] as? [String : Any]
            
            //here as? Int mean what type of value is day_length containing
           // let newData1 = newData!["day_length"] as? Int
          //  print("\(newData1 ?? 11)")
           // let status = jsonObject["status"]
          //  print("\(status)")
    
            
            
            //for array -------------------------------------
           
           guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [[String : Any]] else { return  }
            
            self.apiData = jsonObject
            
            var newVar = self.apiData[2]["rating"] as? [String: Any]
            var newVar1 = newVar!["rate"] as? Double
            print("\(newVar1)")
            //calling index wise title
           // let title = jsonObject[2]
            //  let title2 = title1["title"] as? String
            
            // or we can do it in all together
           // let title1 = jsonObject[2]["title"] as? String
           // print("\(title1)")
          
            //this will print with optional
          //  print("\(title2)")
            //no optional here
          //  print("\(title2 ??  "")")
           // print("\n")
            //calling all indexed titl
//            for i in jsonObject{
//               let title = i["title"]
//                print("\(title ?? "")")
//            }
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
                
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard indexPath.row < apiData.count else {
                return cell
            }
            
        let title = apiData[indexPath.row]["rating"] as? [String : Any]
        let rate = title!["rate"] as? Double
        cell.textLabel?.text = String(format: "%.2f", rate ?? 0.0 )
        return cell
    }
}




