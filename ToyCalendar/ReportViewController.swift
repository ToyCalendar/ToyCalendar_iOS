//
//  ReportViewController.swift
//  ToyCalendar
//
//  Created by 한상준 on 24/03/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet weak var reportBarChart: ReportBarChart!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let dataEntries = generateDataEntries()
        reportBarChart.dataEntries = dataEntries
    }
    
    func generateDataEntries() -> [BarEntry] {
        let colors = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9294117647, alpha: 0.9026380565)
        
        var result: [BarEntry] = []
        for i in 0..<3 {
            let value = (arc4random() % 90) + 10
            let height: Float = Float(value) / 100.0
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            result.append(BarEntry(color: colors, height: height, textValue: "\(value)", title: formatter.string(from: date)))
        }
        return result
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
