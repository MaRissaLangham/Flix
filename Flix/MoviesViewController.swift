//
//  MoviesViewController.swift
//  Flix
//
//  Created by Marissa Langham on 9/18/22.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate //Step 1 Add
{
   
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]() // Array & Dictionary
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Step 3 Add
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        print ("Hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request)
        { (data, response, error) in
             // This will run when the network request returns
             if let error = error
                {
                    print(error.localizedDescription)
                }
            
            else if let data = data
                        
                {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    self.movies = dataDictionary["results"] as! [[String:Any]] //Casting
                
                    self.tableView.reloadData()
                    print(dataDictionary)
                    
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

                }
        }
        task.resume()
    }
    
    // Step 2 Add functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movies.count // step 4.1 add count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    // Step 4.2 Cell Creation
        let cell = tableView.dequeueReusableCell(withIdentifier:"MovieCell") as! MovieCell //dequeueReuseableCell = resusing cell so not too much data
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String // casting = type (string)
        let synopsis = movie["overview"] as! String
        
        cell.titleLabel!.text = title // ?/! swift options
        cell.synopsisLabel.text = synopsis
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
