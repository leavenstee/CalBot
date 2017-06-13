//
//  ViewController.swift
//  FoodRewards
//
//  Created by Steven Lee on 5/31/17.
//  Copyright © 2017 Steven Lee. All rights reserved.
//

import UIKit
import HealthKit
import UserNotifications

var stepz = 0.0

class ViewController: UIViewController {
   // Globals
    var backgroun = 0
    var stepLbl = UILabel()
    var food = [Food]()
    var lowfood = [Food]()
    var medfood = [Food]()
    var highfood = [Food]()
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthKitStuff()
        view.backgroundColor = getRandColor()
        addFoods()
        // Call Health Stuff
        stepLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        
        stepLbl.text = "GET MOVING"
        stepLbl.font = UIFont(name: "Futura", size: 30)
        stepLbl.center = self.view.center
        stepLbl.textColor = .white
        stepLbl.textAlignment = .center
        self.view.addSubview(stepLbl)
        
        let foodLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: 100))
        foodLbl.text = self.getFoodString()
        foodLbl.font = UIFont(name: "Futura", size: 30)
        foodLbl.numberOfLines = 4
        foodLbl.center = CGPoint(x: self.view.center.x, y: self.view.center.y + self.view.center.y/2)
        foodLbl.textAlignment = .center
        self.view.addSubview(foodLbl)
        
        let mapBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        mapBtn.backgroundColor = .black
        mapBtn.addTarget(self, action: #selector(self.goToMap), for: .touchUpInside)
        self.view.addSubview(mapBtn)
        
        
        parseFood()
       
        //background()
        //print(stepz)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToMap(){
        let newView = FoodMap(frame: view.frame,food: food)
        view.addSubview(newView)
    }

    
   
    
    func addFoods(){
        food.append(Food(name: "🍏", realname: "Green Apple", cal: 53))
        food.append(Food(name: "🍎", realname: "Apple", cal: 53))
        food.append(Food(name: "🍐", realname: "Pear", cal: 81))
        food.append(Food(name: "🍊", realname: "Orange", cal: 45))
        food.append(Food(name: "🍋", realname: "Lemon", cal: 2))
        food.append(Food(name: "🍌", realname: "Banana", cal: 48))
        food.append(Food(name: "🍉", realname: "Watermelon", cal: 46))
        food.append(Food(name: "🍇", realname: "Grapes", cal: 104))
        food.append(Food(name: "🍓", realname: "Strawberries", cal: 49))
        food.append(Food(name: "🍈", realname: "Honeydew", cal: 45))
        food.append(Food(name: "🍒", realname: "Cherries", cal: 87))
        food.append(Food(name: "🍑", realname: "Peaches", cal: 51))
        food.append(Food(name: "🍍", realname: "Pineapple", cal: 42))
        food.append(Food(name: "🥝", realname: "Kiwi", cal: 42))
        food.append(Food(name: "🥑", realname: "Avocado", cal: 234))
        food.append(Food(name: "🍅", realname: "Tomatoe", cal: 33))
        food.append(Food(name: "🍆", realname: "Eggplant", cal: 88))
        food.append(Food(name: "🥒", realname: "Cucumber", cal: 45))
        food.append(Food(name: "🥕", realname: "Carrot", cal: 31))
        food.append(Food(name: "🌽", realname: "Corn", cal: 74))
        food.append(Food(name: "🌶", realname: "Hot Pepper", cal: 18))
        food.append(Food(name: "🥔", realname: "Potatoe", cal: 108))
        food.append(Food(name: "🍠", realname: "Sweet Potatoe", cal: 159))
        food.append(Food(name: "🌰", realname: "Chestnut", cal: 21))
        food.append(Food(name: "🥜", realname: "Peanut", cal: 6))
        food.append(Food(name: "🍯", realname: "Honey", cal: 64))
        food.append(Food(name: "🥐", realname: "Croissant", cal: 340))
        food.append(Food(name: "🍞", realname: "Bread", cal: 80))
        food.append(Food(name: "🥖", realname: "Baguette", cal: 151))
        food.append(Food(name: "🧀", realname: "Cheese", cal: 69))
        food.append(Food(name: "🥚", realname: "Hard-Boiled Egg", cal: 78))
        food.append(Food(name: "🍳", realname: "Fried Egg", cal: 78))
        food.append(Food(name: "🥓", realname: "Bacon", cal: 61))
        food.append(Food(name: "🥞", realname: "Pancakes", cal: 154))
        food.append(Food(name: "🍤", realname: "Shrimp", cal: 5))
        food.append(Food(name: "🍗", realname: "Chicken Leg", cal: 216))
        food.append(Food(name: "🍖", realname: "Rib", cal: 185))
        food.append(Food(name: "🍕", realname: "Pizza", cal: 290))
        food.append(Food(name: "🌭", realname: "Hot Dog", cal: 365))
        food.append(Food(name: "🍔", realname: "Cheeseburger", cal: 479))
        food.append(Food(name: "🍟", realname: "French Fries", cal: 300))
        food.append(Food(name: "🥙", realname: "Falafel", cal: 779))
        food.append(Food(name: "🥗", realname: "Salad", cal: 33))
        food.append(Food(name: "🌮", realname: "Taco", cal: 170))
        food.append(Food(name: "🌯", realname: "Burrito", cal: 430))
        food.append(Food(name: "🥘", realname: "Stew", cal: 143))
        food.append(Food(name: "🍝", realname: "Spaghetti", cal: 412))
        food.append(Food(name: "🍜", realname: "Ramen", cal: 376))
        food.append(Food(name: "🍲", realname: "Wonton", cal: 250))
        food.append(Food(name: "🍣", realname: "Sushi", cal: 134))
        food.append(Food(name: "🍚", realname: "White Rice", cal: 205))
        food.append(Food(name: "🍧", realname: "Shaved Ice", cal: 30))
        food.append(Food(name: "🍨", realname: "Ice Cream", cal: 273))
        food.append(Food(name: "🍦", realname: "Ice Cream", cal: 200))
        food.append(Food(name: "🍰", realname: "Cake", cal: 340))
        food.append(Food(name: "🍭", realname: "Lollipop", cal: 51))
        food.append(Food(name: "🍬", realname: "Hard Candy", cal: 23))
        food.append(Food(name: "🍫", realname: "Chocolate", cal: 210))
        food.append(Food(name: "🍩", realname: "Doughnut", cal: 190))
        food.append(Food(name: "🍪", realname: "Cookie", cal: 220))
        food.append(Food(name: "🥛", realname: "Milk", cal: 122))
        food.append(Food(name: "☕️", realname: "Coffee", cal: 2))
        food.append(Food(name: "🍺", realname: "Miller Lite", cal: 97))
        food.append(Food(name: "🍸", realname: "Martini", cal: 135))
        food.append(Food(name: "🍷", realname: "Wine", cal: 126))
        food.append(Food(name: "🥃", realname: "Whiskey", cal: 100))
    }
    
    
    func parseFood(){
        var t = 0.0
        for i in food{
            t = t + i.cal
            if(i.cal < 55){
                lowfood.append(i)
            }else if (i.cal < 144){
                medfood.append(i)
            } else {
                highfood.append(i)
            }
        }
  
    }
    
    
    
    func healthKitStuff(){
        let stepsCount = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let dataTypesToRead = NSSet(object: stepsCount!)
        
        healthStore?.requestAuthorization(toShare: dataTypesToRead as? Set<HKSampleType>,
                                          read: dataTypesToRead as? Set<HKObjectType>,
                                          completion: { (success, error) in
                                            if success {
                                                //print("SUCCESS")
                                            } else {
                                                //print(error!)
                                            }
        })
        
        let calendar = Calendar.current
        var interval = DateComponents()
        interval.day = 1
        
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date() as Date)
        anchorComponents.hour = 0
        let anchorDate = calendar.date(from: anchorComponents)
        
        // Define 1-day intervals starting from 0:00
        let stepsQuery = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: interval as DateComponents)
        // Set the results handler
        stepsQuery.initialResultsHandler = {query, results, error in
            let endDate = NSDate()
            let startDate = calendar.date(byAdding: .day, value: 0, to: endDate as Date, wrappingComponents: false)
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let date = statistics.startDate
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        //print("\(date): steps = \(steps)")
                        //NOTE: If you are going to update the UI do it in the main thread
                        stepz = steps
                        DispatchQueue.main.async {
                            //update UI components
                            self.stepLbl.text = "\(stepz)"
                        }
                        
                    }
                } //end block
            }
        }
        healthStore!.execute(stepsQuery)
        
        
    }
    
    func getFoodString() -> String{
        var temp = (stepz * 0.045) + 77
       // var temp = 7360.18706737519 * 0.045
        //////print(temp)
        var str = ""
        while (temp > 1){
            // Random Food Try
            let diceRoll = Int(arc4random_uniform(UInt32(food.count)))
            let rFood = food[diceRoll]
            if (rFood.cal < temp){
                temp = temp - rFood.cal
                str = str + "\(rFood.name)"
            }
        }
        //////print(temp)
        return str
    }
    
    func getRandColor() -> UIColor {
        let dice = arc4random_uniform(10)
        
        if(dice == 0){
            return UIColor(red:0.65, green:0.95, blue:0.91, alpha:1.0)
        } else if(dice == 1){
            return UIColor(red:1.00, green:0.87, blue:0.87, alpha:1.0)
        } else if(dice == 2){
            return UIColor(red:0.80, green:0.66, blue:0.91, alpha:1.0)
        } else if(dice == 3){
            return UIColor(red:0.96, green:0.80, blue:0.43, alpha:1.0)
        } else if(dice == 4){
            return UIColor(red:0.13, green:0.78, blue:0.66, alpha:1.0)
        } else if(dice == 5){
            return UIColor(red:1.00, green:0.67, blue:0.65, alpha:1.0)
        } else if(dice == 6){
            return UIColor(red:1.00, green:0.27, blue:0.27, alpha:1.0)
        } else if(dice == 7){
            return UIColor(red:0.23, green:0.34, blue:0.49, alpha:1.0)
        } else if(dice == 8){
            return UIColor(red:0.98, green:0.95, blue:0.36, alpha:1.0)
        } else if(dice == 9){
            return UIColor(red:0.64, green:0.29, blue:0.29, alpha:1.0)
        } else {
            return UIColor(red:0.95, green:0.20, blue:0.96, alpha:1.0)
        }
    }
    
    func background(){
        let sampleType =
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let query = HKObserverQuery(sampleType: sampleType!, predicate: nil) {
            query, completionHandler, error in
            
            if error != nil {
                
                // Perform Proper Error Handling Here...
                //print("*** An error occured while setting up the stepCount observer. \(error?.localizedDescription) ***")
                abort()
            }
            
            // Take whatever steps are necessary to update your app's data and UI
            // This may involve executing other queries
           // completionHandler
            
            
            // If you have subscribed for background updates you must call the completion handler here.
            // completionHandler()
        }
        
        healthStore?.execute(query)
        healthStore?.enableBackgroundDelivery(for: sampleType!, frequency: .hourly) { (complete, error) in
            //print("WOW")
            self.view.backgroundColor = .white
        }
    }
    
  
  
  
}


class Food {
    /*
 🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥝🥑🍅🍆🥒🥕🌽🌶🥔🍠🌰🥜🍯🥐🍞🥖🧀🥚🍳🥓🥞🍤🍗🍖🍕🌭🍔🍟🥙🌮🌯🥗🥘🍝🍜🍲🍥🍣🍱🍛🍚🍙🍘🍢🍡🍧🍨🍦🍰🎂🍮🍭🍬🍫🍿🍩🍪🥛🍼☕️🍵🍶🍺🍻🥂🍷🥃🍸🍹🍾
 */
    var name = "🚶‍♀️🚶🏻🏃🏼‍♀️🏃🏽"
    var realname = ""
    var cal = 0.0
    
    init(name:String,realname:String,cal:Double) {
        self.name = name
        self.realname = realname
        self.cal = cal
    }
}
