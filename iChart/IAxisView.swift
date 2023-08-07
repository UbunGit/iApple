//
//  IAxisView.swift
//  iTest
//
//  Created by admin on 2023/8/1.
//

import UIKit

public class IAxisView: UIView {
    var labelCount:Int = 4
    lazy var textAttributes: [NSAttributedString.Key:Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        return [
            .font: UIFont.systemFont(ofSize: 8),
            .foregroundColor:UIColor.secondaryLabel,
            .paragraphStyle: paragraphStyle,
        ]
    }()
    
    lazy var dataSet:IChartDataSet = .init(entyrs: IChartEntrie.random())
  
    var formatter = IYAxisChartFormatter()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        self.drawYAxis(drawRect: rect,
                       chartSet: dataSet,
                       textAttributes: textAttributes)
    }
   
    
}
struct IYAxisChartFormatter:IChartFormatter{
    
}
