//
//  TrendsMoreSheet.swift
//  Trends
//
//  Created by mac on 2023/7/18.
//

import SwiftUI
class TrendsMoreSheetViewController:UIViewController{
    
    var manage:TrendsItemViewListController.Manage!
    var trend:TrendsData!
    var tapGestureBlock:((_ index:Int)->())!
    lazy var body: UIView = {
        let value = UIHostingController(rootView: TrendsMoreSheet(tapGestureBlock: tapGestureBlock)
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
            make.height.equalTo(380)
        }
    }
}
struct TrendsMoreSheet: View {
    var tapGestureBlock:(_ index:Int)->()
    
    var body: some View {
        
        
        Color(UIColor.systemBackground)
            .frame(width: 68  ,height: 4)
            .cornerRadius(2)
            .padding()
        
        List{
            
            Section(){
                HStack{
                    Text("不看")
                    Spacer()
                }
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .onTapGesture {
                    tapGestureBlock(0)
                }
                
            }
        
            Section{
                HStack{
                    Text("隐藏")
                    Spacer()
                }
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .onTapGesture {
                    tapGestureBlock(1)
                }
                HStack{
                    Text("拉黑")
                    Spacer()
                }
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .foregroundColor(Color.red)
                .onTapGesture {
                    tapGestureBlock(2)
                }
                HStack{
                    Text("举报")
                    Spacer()
                }
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .foregroundColor(Color.red)
                .onTapGesture {
                    tapGestureBlock(3)
                }
            }
        }
        
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(32)
        
    }
}

struct TrendsMoreSheet_Previews: PreviewProvider {
    static var previews: some View {
        TrendsMoreSheet(tapGestureBlock: { index in
            
        })
    }
}
