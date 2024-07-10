//
//  TrendsReportView.swift
//  Trends
//
//  Created by mac on 2023/7/18.
//

import SwiftUI
class TrendsReportViewController:BaseViewController{

    var trend:TrendsData!

    lazy var body: UIView = {
        let value = UIHostingController(rootView: TrendsReportView(tapGestureBlock: { index in
            self.navigationController?.popViewController(animated: true)
        })
        ).view
        value?.backgroundColor = .clear
        return value!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        
    }
    func makeUI(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.32)
        view.addSubview(body)
    }
    func makeLayout(){
        body.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
struct TrendsReportView: View {

    var tapGestureBlock:((_ index:Int)->())
    var data:[String] = ["没有理由，就是不喜欢","垃圾信息","仇恨言论或符号","色情暴力","虚假内容","骚扰信息","欺骗或诈骗内容","销售违禁物品","广告推销内容","其他"]
    var body: some View {
        List{
            ForEach((0..<data.count),id:\.self) { index in
                HStack{
                    Text(data[index])
                    Spacer()
                }
                .frame(height: 64)
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .onTapGesture {
                    tapGestureBlock(index)
                }
            }
        }
    }
}

struct TrendsReportView_Previews: PreviewProvider {
    static var previews: some View {
        TrendsReportView(tapGestureBlock:{ index in
        })
    }
}
