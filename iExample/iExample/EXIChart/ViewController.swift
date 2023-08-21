//
//  ViewController.swift
//  EXIChart
//
//  Created by 恋遇 on 2023/8/8.
//

import UIKit
import iApple
import SnapKit
class ViewController: UIViewController {

    lazy var pieview: IChartPieView = {
        let value = IChartPieView()
        return value
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        reloadData()
    
    }
    func makeUI(){
        view.addSubview(pieview)
    }
    
    func reloadData(){
        pieview.dataSet = .init(entyrs: [
            IChartPieEntrie.init(x: 0, y: 100,color: UIColor.red),
            IChartPieEntrie.init(x: 1, y: 50,color: UIColor.green),
            IChartPieEntrie.init(x: 2, y: 60,color: UIColor.blue),
            IChartPieEntrie.init(x: 3, y: 30,color: UIColor.yellow),
            IChartPieEntrie.init(x: 4, y: 80,color: UIColor.brown),
            IChartPieEntrie.init(x: 5, y: 10,color: UIColor.orange),
   
        ])
        pieview.reload()
    }
    
    func makeLayout(){
        pieview.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: 0, y: 1)
        IChartPieDrawView().angleDegrees(point1: point1, point2: point2)
    }


}

