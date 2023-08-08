//
//  IChartView.swift
//  iTest
//
//  Created by admin on 2023/8/1.
//

import UIKit

open class IChartDrawView:UIView{
    public var drawColor:UIColor = .systemRed
    public var xAxisformatter:IChartFormatter = IChartXAxisFormatter()
    public lazy var dataSet:IChartDataSet = .init(entyrs: IChartEntrie.random())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
}
open class IChartView: UIView {
    

    public lazy var scrollerView = UIScrollView()
    public lazy var drawView:IChartDrawView = IChartDrawView()
    public lazy var dataSet:IChartDataSet = IChartDataSet(entyrs: [])
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeUI()
        makeLayoout()
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func makeUI(){
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.showsHorizontalScrollIndicator = false
     
        addSubview(scrollerView)
        scrollerView.addSubview(drawView)
       
    }
    open func makeLayoout(){
       
        scrollerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        drawView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(self)
            make.width.equalTo(self)
        }
        
    }
    
    
    open func reload(){
        dataSet.reset()
     
        drawView.dataSet = dataSet
        dataSet.cellWidth = max((bounds.width-36-12)/CGFloat(dataSet.entyrs.count), 40)
       
        drawView.setNeedsDisplay()
   
    }
 
}

extension UIView{
    
    
    func drawYAxis(
        drawRect:CGRect,
        labelCount:Int=4,
        chartSet:IChartDataSet,
        textAttributes:[NSAttributedString.Key:Any]
    ){
        
        let formate:IChartFormatter = IYAxisChartFormatter()
        
        (0...labelCount).forEach { item in
            var offse:CGFloat = 0
            if item == 0{
                offse = -12
            }
            let y:CGFloat = CGFloat(item)/CGFloat(labelCount)
            let point = CGPoint(x: 0, y: y)
            var grapPoint = chartSet.leftPoint( point: point,rect: drawRect)
            grapPoint.y = grapPoint.y+offse
            let textrect = CGRect(origin: grapPoint, size: .init(width: drawRect.width, height: 32))
            let text = formate.stringForValue(Double(y*chartSet.y_max))
            text.draw(in: textrect, withAttributes: textAttributes)
            
        }
        
    }
    
    func drawLineContent(
        drawRect:CGRect,
        chartSet:IChartDataSet,
        linePath:UIBezierPath,
        index:Int,
        textAttributes:[NSAttributedString.Key:Any]
    ){
      
        
        let entyr = chartSet.entyrs[index]
        let grapPoint = chartSet.point(entyr: entyr, rect: drawRect)
        // 线
        let linePath = linePath
        if index == 0{
            linePath.move(to: grapPoint)
        }else{
            let preEntyr = chartSet.entyrs[index-1]
            let pregrapPoint = chartSet.point(entyr: preEntyr, rect: drawRect)
            linePath.i_addCurvedLineSegment(prePoint: pregrapPoint, endPoint: grapPoint)
        }
     
        
        let line = UIBezierPath()
        let begin = CGPoint(x: grapPoint.x, y: drawRect.origin.y)
        line.move(to: begin)
        let end = CGPoint(x: grapPoint.x, y: drawRect.height)
        line.addLine(to: end)
        line.lineWidth = 1
        UIColor.systemGroupedBackground.setStroke()
        line.stroke()
    }
}
