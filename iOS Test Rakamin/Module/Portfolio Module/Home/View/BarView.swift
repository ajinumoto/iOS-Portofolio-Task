//
//  BarView.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import UIKit
import DGCharts

class BarView: UIView {
    private var barChart: BarChartView!
    var barChartData: LineModelData? {
        didSet {
            updateChartData(data: barChartData)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBarChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBarChart() {
        barChart = BarChartView()
        barChart.pinchZoomEnabled = false
        barChart.isUserInteractionEnabled = false
        barChart.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(barChart)
        
        NSLayoutConstraint.activate([
            barChart.topAnchor.constraint(equalTo: topAnchor),
            barChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            barChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            barChart.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateChartData(data: LineModelData?) {
        
        var barEntry = [BarChartDataEntry]()
        var barColors: [UIColor] = []
        let monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        var month = 0
        for data in barChartData?.month ?? [] {
            barEntry.append(BarChartDataEntry(x: Double(month), y: Double(data)))
            barColors.append(UIColor.randomColor())
            month += 1
        }
        
        let lineSet = BarChartDataSet(entries: barEntry, label: "")
        lineSet.colors = barColors
        
        let lineChartData = BarChartData(dataSet: lineSet)
        barChart.data = lineChartData
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: monthNames)
        barChart.xAxis.labelPosition = .topInside
        barChart.xAxis.enabled = true
        barChart.xAxis.labelTextColor = .black

        barChart.rightAxis.labelPosition = .insideChart
        barChart.rightAxis.enabled = true
        barChart.rightAxis.labelTextColor = .black


    }
}
