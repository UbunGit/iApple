//
//  ILineChartView.swift
//  iTest
//
//  Created by admin on 2023/8/1.
//

import SwiftUI
import UIKit
import SnapKit


open class IChartLineView:IChartView{
    public lazy var left_AxisView:IAxisView = IAxisView()
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
  
    open override func makeUI() {
        addSubview(left_AxisView)
        drawView = IChartLineDrawView()
        dataSet = IChartDataSet(entyrs: IChartEntrie.random())
        super.makeUI()
        scrollerView.alwaysBounceVertical = false
    }
    open override func makeLayoout() {
        super.makeLayoout()
       
        left_AxisView.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(24)
            make.bottom.equalToSuperview().offset(-24)
        }
        scrollerView.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        drawView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(self).offset(-4)
            make.width.equalTo(0)
        }
    }
  
    public override func reload(){
       
       
        drawView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(self).offset(-4)
            make.width.equalTo(dataSet.cellWidth*CGFloat( dataSet.entyrs.count))
        }
        layoutIfNeeded()
        left_AxisView.dataSet = dataSet
        left_AxisView.setNeedsDisplay()
        drawView.setNeedsDisplay()
        super.reload()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

open class IChartLineDrawView:IChartDrawView{
    var selectIndex:Int = 0

    lazy var textAttributes: [NSAttributedString.Key:Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [
            .font: UIFont.systemFont(ofSize: 12),
            .paragraphStyle: paragraphStyle,
        ]
    }()
   
  
    var lineCurviness: CGFloat = 0.5
  
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
        
    }
    @objc func tapGesture(gesture:UIGestureRecognizer){
        let tapLocation = gesture.location(in: self)
        let index = Int(tapLocation.x/dataSet.cellWidth)
        if index<dataSet.entyrs.count{
            selectIndex =  Int(tapLocation.x/dataSet.cellWidth)
        }
        
        self.setNeedsDisplay()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func draw(_ rect: CGRect) {
  
        super.draw(rect)
        let linePath = UIBezierPath()
        let context = UIGraphicsGetCurrentContext()
        
        var lineRect = rect
        lineRect.origin.y = rect.origin.y + 24
        lineRect.size.height = rect.size.height-24
        
        let xAsixRect = CGRectMake(0, rect.height-24, rect.width, 24)

        
        dataSet.entyrs.enumerated().forEach { (index,entyr) in
            
            self.drawLineContent(drawRect: lineRect, chartSet: dataSet,linePath: linePath, index: index,textAttributes: textAttributes)
            self.drawXAxis(drawRect: xAsixRect, chartSet: dataSet, linePath: linePath, index: index, textAttributes: textAttributes)
        }
        linePath.lineWidth = 3
        drawColor.setStroke()
        drawColor.withAlphaComponent(0.3).setFill()
        linePath.stroke()
        context?.saveGState()
        
        
        var circleRect = rect
        circleRect.origin.y = rect.origin.y + 24
        circleRect.size.height = rect.size.height-24
        guard let selectEntry = dataSet.entyrs.value(at: selectIndex) else {
            return
        }
        let circlePoint = dataSet.point(entyr:selectEntry , rect: circleRect)
   
        // 标记点
        let circlePath = UIBezierPath(arcCenter: circlePoint, radius: 6.0, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        circlePath.lineWidth = 4
        
        let shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        let shadowOffset = CGSize(width: 0, height: 0)
        let shadowBlurRadius: CGFloat = 4
        context?.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color:shadowColor)
        
        UIColor.white.setStroke()
        drawColor.setFill()
        circlePath.stroke()
        circlePath.fill()
        //
        let remarkPoint = CGPoint(x: circlePoint.x-dataSet.cellWidth/2, y: circlePoint.y-24)
        let text = String.init(format: "¥%0.0f", selectEntry.y)
        let textrect = CGRect(origin: remarkPoint, size: .init(width: dataSet.cellWidth, height: 32))
        text.draw(in: textrect, withAttributes: self.textAttributes)
        
    
    }
    
    func drawXAxis(
        drawRect:CGRect,
        chartSet:IChartDataSet,
        linePath:UIBezierPath,
        index:Int,
        textAttributes:[NSAttributedString.Key:Any]
    ){
        
        
        let entyr = chartSet.entyrs[index]
        var grapPoint = chartSet.point(entyr: entyr, rect: drawRect)
        let itemW = drawRect.width/CGFloat(chartSet.entyrs.count)
        grapPoint.y = drawRect.origin.y+drawRect.size.height-14
        grapPoint.x = grapPoint.x-itemW/2
        
        // X index
        let xtext = xAxisformatter.stringForValue(entyr.x)
        let xtextRect = CGRect(origin: grapPoint,
                               size: .init(width: Int(drawRect.width)/chartSet.entyrs.count, height: 32)
        )
        xtext.draw(with: xtextRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: textAttributes, context: nil)

        
    }
}
extension Double{
    func normalized(min:Double,max:Double)->Double{
        let a = self - min
        let b = max - min
        return  a/b
    }
}



extension UIBezierPath{
    func i_addCurvedLineSegment(prePoint: CGPoint,
                              endPoint: CGPoint,
                              lineCurviness:CGFloat = 0.5) {
        // calculate control points
        let difference = endPoint.x - prePoint.x
        
        var x = prePoint.x + (difference * lineCurviness)
        var y = prePoint.y
        let controlPointOne = CGPoint(x: x, y: y)
        
        x = endPoint.x - (difference * lineCurviness)
        y = endPoint.y
        let controlPointTwo = CGPoint(x: x, y: y)
        
        // add curve from start to end
        self.addCurve(to: endPoint, controlPoint1: controlPointOne, controlPoint2: controlPointTwo)
    }
}

