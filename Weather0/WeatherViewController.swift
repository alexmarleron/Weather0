//
//  ViewController.swift
//  Weather0
//
//  Created by san on 17.09.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func locationButtonPressed(_ sender: UIButton) {
    }

}
//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
 
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        //done with editing and dismiss keyboard
//        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    //return key in the keyboard was pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        //done with editing and dismiss keyboard
        searchTextField.endEditing(true)
        return false // true<<
    }
    //reset searchText
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    //placeholder for type something
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter the City Name"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_  weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
        print(weather.temperature)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
