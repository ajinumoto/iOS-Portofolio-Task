//
//  PieChartViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import UIKit
import DGCharts

class PieView: UIView, ChartViewDelegate {
    
    private var pieChart: PieChartView!
    var pieChartData = [PieChartDatum]() {
        didSet {
            updateChartData(data: pieChartData)
        }
    }
    private weak var navigationController: UINavigationController?
    
    init(frame: CGRect, navigationController: UINavigationController?) {
        super.init(frame: frame)
        self.navigationController = navigationController
        setupPieChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPieChart() {
        pieChart = PieChartView()
        pieChart.delegate = self
        pieChart.rotationEnabled = false
        pieChart.legend.textColor = .black
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pieChart)
        
        NSLayoutConstraint.activate([
            pieChart.topAnchor.constraint(equalTo: topAnchor),
            pieChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            pieChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            pieChart.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateChartData(data: [PieChartDatum]) {
        
        var pieEntry = [PieChartDataEntry]()
        var pieColors: [UIColor] = []
        
        for data in pieChartData {
            if let value = Double(data.percentage) {
                pieEntry.append(PieChartDataEntry(value: value, label: data.label))
            }
            pieColors.append(UIColor.randomColor())
        }
        
        let pieSet = PieChartDataSet(entries: pieEntry, label: "")
        pieSet.colors = pieColors
        
        let pieChartData = PieChartData(dataSet: pieSet)
        pieChart.data = pieChartData
    }
    
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let i = Int(highlight.x)
        guard let label = pieChart.legend.entries[i].label else { return }
        guard let selectedData = pieChartData.first(where: { $0.label == label }) else { return }
        
        
        let detailView = DetailPortofolioRouter.createModule(pieModel: selectedData.data)
        navigationController?.pushViewController(detailView, animated: true)
        
    }
}
