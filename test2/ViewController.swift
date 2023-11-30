
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var table : UITableView!
    var res : Response?
    
    @IBAction func buttonClick(_ sender : UIButton){
        let url = "https://api.sunrise-sunset.org/json?date= 2020-01-01&lat=-74.0060&lng=40.7128&formatted=0"
        fetchApiData(with : url)
          sender.isHidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    func fetchApiData(with url : String){
        
        let task =   URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
        guard let data = data, error == nil else{
                print("Something went wrong")
                return
            }
            
            do{
                self.res = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
              print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = self.res else{
                return
            }
            print(self.res?.status)
            print(json.results.sunrise)
            print(json.results.sunset)
            print(json.results.solar_noon)
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(self.res?.status ?? "hello")"
        return cell
    }
}

struct Response : Codable {
    let results : MyResult
    let status : String
}

struct MyResult : Codable {
    let sunrise : String
    let sunset : String
    let solar_noon : String
    let day_length : Int
    let civil_twilight_begin : String
    let civil_twilight_end : String
    let nautical_twilight_begin : String
    let nautical_twilight_end : String
    let astronomical_twilight_begin : String
    let astronomical_twilight_end : String
}



