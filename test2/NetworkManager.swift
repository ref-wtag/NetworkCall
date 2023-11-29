import Foundation

class NetworkManager {
    public func getProducts(
    completion: @escaping (Result<[Product], Error>) -> ()
    )  {
        let url = URL(string: "https://fakestoreapi.com/products")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
