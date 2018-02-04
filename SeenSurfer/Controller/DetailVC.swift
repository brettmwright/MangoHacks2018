//
//  DetailVC.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/4/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import UIKit
import Charts
import FirebaseDatabase

class DetailVC: UIViewController {

    
    @IBOutlet weak var vibeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var barChart: HorizontalBarChartView!
    
    var venue: SeenSurferVenue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVenueData()
        // Do any additional setup after loading the view.
    }
    
    func getVenueData() {
        let ref = Database.database().reference()
        let venueRef = ref.child("venues/1")
        _ = venueRef.observe(.value, with: { (snapshot) in
            guard let venueDict = snapshot.value as? [String:Any] else { return }
            self.venue = SeenSurferVenue(withDict: venueDict)
            self.titleLabel.text = self.venue?.name ?? ""
            self.vibeLabel.text = "\(self.venue?.vibeRating ?? 0)"
            self.pieChartUpdate()
            self.barChartUpdate()
            guard let imageUrlString = self.venue?.imageUrl, let url = URL(string: imageUrlString) else { return }
            SeenSurferUtils.shared.set(imageView: self.imageView, withImageAtUrl: url)
        })
    }
    
    func barChartUpdate() {
        guard let _venue = venue, let lowRange = _venue.averageLowAgeRange, let highRange = _venue.averageHighAgeRange else { return }
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(lowRange))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(highRange))
        let dataSet = BarChartDataSet(values: [entry1, entry2], label: "Age")
        dataSet.colors = ChartColorTemplates.liberty()
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        //barChart.chartDescription?.text = "Number of Widgets by Type"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        barChart.notifyDataSetChanged()
    }
    
    func pieChartUpdate() {
        guard let _venue = venue, let maleCount = _venue.maleOccupancyCount, let femaleCount = _venue.femaleOccupancyCount, let total = _venue.totalBodyCount else { return }
        let entry1 = PieChartDataEntry(value: maleCount, label: "Male")
        let entry2 = PieChartDataEntry(value: femaleCount, label: "Female")
        let entry3 = PieChartDataEntry(value: Double(total), label: "Total")
        let dataSet = PieChartDataSet(values: [entry1, entry2, entry3], label: "Gender Demographics")
        dataSet.colors = ChartColorTemplates.liberty()
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        //pieChart.chartDescription?.text = "Share of Widgets by Type"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        pieChart.notifyDataSetChanged()
    }


}
