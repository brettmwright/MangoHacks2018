//
//  MainVC.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import UIKit
import SocketIO
import FirebaseDatabase

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var venueArray: [SeenSurferVenue]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        venueArray = []
        tableView.delegate = self
        tableView.dataSource = self
        getVenueData()
        getAllVenues()
    }
    
    func getAllVenues() {
        let ref = Database.database().reference()
        let venueRef = ref.child("venues")
        _ = venueRef.observe(.value, with: { (snapshot) in
            self.venueArray = []
            
            guard let venueArr = snapshot.value as? [Any] else { return }
            for venue in venueArr {
                if let venueDict = venue as? [String:Any] {
                    let newVenue = SeenSurferVenue(withDict: venueDict)
                    self.venueArray?.append(newVenue)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }
    
    func getVenueData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            SocketIOManager.shared.retrieveVenueUpdates(completionHandler: { (dataArray) in
                let venue = self.generateVenueData(dataArray: dataArray)
                if venue.averageHighAgeRange == 0 || venue.averageLowAgeRange == 0 || venue.totalBodyCount == 0 {
                    return
                }
                let updateDict: [String:Any] = [
                    String("femaleOccupancyPercentage"): venue.femaleOccupancyPercentage ?? 0 as? Double,
                    String("maleOccupancyPercentage"): venue.maleOccupancyPercentage ?? 0 as? Double,
                    String("femaleOccupancyCount"): venue.femaleOccupancyCount ?? 0 as? Int,
                    String("maleOccupancyCount"): venue.maleOccupancyCount ?? 0 as? Int,
                    String("averageLowAgeRange"): venue.averageLowAgeRange ?? 0 as? Int,
                    String("averageHighAgeRange"): venue.averageHighAgeRange ?? 0 as? Int,
                    String("totalBodyCount"): venue.totalBodyCount ?? 0 as? Int,
                    String("vibeRating"): venue.vibeRating ?? 0 as? Double
                ]
                
                let ref = Database.database().reference()
                ref.child("venues/1").updateChildValues(updateDict)
            })
        }
    }
    
    func generateVenueData(dataArray: [AWSFaceDetail]) -> SeenSurferVenue {
        var maleCount = 0
        var femaleCount = 0
        var totalBodyCount = 0
        var lowAgeArray: [Int] = []
        var highAgeArray: [Int] = []
        var emotionScore = 0
        
        for item in dataArray {
            if let emotions = item.Emotions {
                for emotion in emotions {
                    
                    if let emotionType = emotion.Type, let emotionConfidence = emotion.Confidence {
                        switch (emotionType) {
                            case "HAPPY", "SUPRISED":
                                if emotionConfidence > 89 {
                                    emotionScore += 2
                                }
                            break
                            case "SAD", "ANGRY", "DISGUSTED":
                                if emotionConfidence > 89 {
                                    emotionScore -= 1
                                }
                            break
                            default:
                            break
                        }
                    }
                }
            }
            
            if let isSmiling = item.Smile?.Value, isSmiling {
                emotionScore += 1
            }
            
            if item.Gender?.Value == "Male" {
                maleCount += 1
            } else if item.Gender?.Value == "Female" {
                femaleCount += 1
            }
            
            totalBodyCount += 1
            
            if let ageHigh = item.AgeRange?.High, let ageLow = item.AgeRange?.Low {
                lowAgeArray.append(ageLow)
                highAgeArray.append(ageHigh)
            }
        }
        
        let venue = SeenSurferVenue()
        
        var lowAgeSum = 0
        var highAgeSum = 0
        
        for age in lowAgeArray {
            lowAgeSum += age
        }
        
        for age in highAgeArray {
            highAgeSum += age
        }
        
        let lowAgeRange = lowAgeArray.count == 0 ? 0 : lowAgeSum / lowAgeArray.count
        let highAgeRange = highAgeArray.count == 0 ? 0 : highAgeSum / highAgeArray.count
        let malePercentage = totalBodyCount == 0 ? 0 : ((Double(maleCount) / Double(totalBodyCount)) * 100)
        let femalePercentage = totalBodyCount == 0 ? 0 : ((Double(femaleCount) / Double(totalBodyCount)) * 100)
        
        
        venue.averageLowAgeRange = lowAgeRange
        venue.averageHighAgeRange = highAgeRange
        venue.maleOccupancyPercentage = malePercentage
        venue.femaleOccupancyPercentage = femalePercentage
        venue.totalBodyCount = totalBodyCount
        venue.maleOccupancyCount = Double(maleCount)
        venue.femaleOccupancyCount = Double(femaleCount)
        venue.vibeRating = emotionScore < 0 ? 0 : Double(emotionScore)
        return venue
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell") as? VenueTableViewCell {
            if let _venueArray = venueArray {
                cell.configureCell(withVenue: _venueArray[indexPath.row])
            }
            return cell
        }
        return VenueTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let venueArray = self.venueArray else { return }
            let venue = venueArray[indexPath.row]
            performSegue(withIdentifier: "MainVCToDetailVC", sender: nil)
        }
    }
    
}

