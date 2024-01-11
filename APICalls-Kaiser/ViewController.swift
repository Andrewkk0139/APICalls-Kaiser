//
//  ViewController.swift
//  APICalls-Kaiser
//
//  Created by ANDREW KAISER on 1/8/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lableOutlet: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
    }
    func getWeather(){
        // creating object of URLSession class to make api call
        let session = URLSession.shared

                //creating URL for api call (you need your apikey)
        // JUST MAKING A URL
                let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=42.24&lon=-88.31&units=imperial&appid=d1a66b2abff510267814f70b4f0e3339")
                // Making an api call and creating data in the completion handler
        // THIS ACTUALLY MAKES THE API
        let dataTask = session.dataTask(with: weatherURL!) {
            // completion handler: happens on a different thread, could take time to get data
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let e = error {
                print("Error:\n\(e)")
            } else {
                // if there is data
                if let d = data {
                    // convert data to json Object
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? NSDictionary {
                        // print the jsonObj to see structure
                        print(jsonObj)
                        // jsonObj is an object with tons dictionaries.
                        if let main = jsonObj.value(forKey: "main") as? NSDictionary{
                            if let minTemp = main.value(forKey: "temp_min") as? Double {
                                DispatchQueue.main.async{
                                    self.minLabel.text = "\(minTemp)"
                                }
                            }
                            if let maxTemp = main.value(forKey: "temp_max") as? Double {
                                DispatchQueue.main.async{
                                    self.maxLabel.text = "\(maxTemp)"
                                }
                            }
                            if let humidity = main.value(forKey: "humidity") as? Double {
                                DispatchQueue.main.async{
                                    self.humidityLabel.text = "\(humidity)"
                                }
                            }
                            if let temp = main.value(forKey: "temp") as? Double{
                                // Making this code happen in the main thread, because this closure is operating on a different thread
                                DispatchQueue.main.async {
                                    self.lableOutlet.text = "\(temp)"
                                }
                            }
                        }
                        if let sys = jsonObj.value(forKey: "sys") as? NSDictionary{
                            if let sunset = sys.value(forKey: "sunset") as? Double{
                                DispatchQueue.main.async {
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }


}

