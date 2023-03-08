//
//  ShowImageView.swift
//  iPotho
//
//  Created by mac on 2023/2/25.
//

import UIKit
import SnapKit
import SwiftUI
import SDWebImage
class ShowImageView:UIView {
    init(datas:[String],index:Int = 0){
      
        self.datas = datas
        self.index = index
        super.init(frame: .zero)
        self.makeUI()
        self.makeLayout()
        countLab.text = "\(index+1)/\(datas.count)"
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35) {
            
            self.collectionView.scrollToItem(at: .init(row: self.index, section: 0), at: .centeredHorizontally, animated: false)
            UIView.animate(withDuration: 0.35) {
                self.collectionView.alpha = 1
            }
        }
       
       
    }
    
    var datas:[String]{
        didSet{
            collectionView.reloadData()
        }
    }
    var index:Int{
        didSet{
            if index<datas.count{
                self.collectionView.scrollToItem(at: .init(row: self.index, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
    lazy var countLab: UILabel = {
        let value = UILabel()
        value.font = .boldSystemFont(ofSize: 20)
        value.textColor = .white
      
        return value
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let value = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        value.backgroundColor = .clear
        value.isPagingEnabled = true
        value.delegate = self
        value.dataSource = self
        value.contentInsetAdjustmentBehavior = .never
        value.alpha = 0
        value.i_register(cellType: ShowImageCell.self, bundle: nil)
        return value
    }()
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI(){
        addSubview(collectionView)
        addSubview(countLab)
        
    }
    func makeLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        countLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIScreen.i_safeAreaInsets.top+32)
        }
        
    }
    
}

extension ShowImageView:I_UICollectionViewProtocol{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.i_dequeueReusableCell(with: ShowImageCell.self, for: indexPath)
        let celldata = datas[indexPath.row]
        cell.imageView.sd_setImage(with:.init(string: celldata))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let w = Int(self.collectionView.bounds.width)
        let x = Int(self.collectionView.contentOffset.x)
        
        let index = (x+w/2) / w
        self.countLab.text = "\(index + 1)/\(self.datas.count)"
        
        let o = CGFloat(x%w)
        let of = abs(o-CGFloat(w/2))/CGFloat(w/2)
        self.countLab.alpha = of
    }
    
}


open class ShowImageVC:UIViewController{
    public var datas:[String] = []
    var index:Int = 0
    
    lazy var closeBtn: UIButton = {
        let value = UIButton(frame: .init(origin: .zero, size: .init(width: 32, height: 32)))
        value.i_radius = 4
        value.backgroundColor = .systemGroupedBackground
        value.setTitleColor(.black, for: .normal)
        value.setImage(.init(systemName: "chevron.left"), for: .normal)
        value.tintColor = .tertiaryLabel
        value.addTarget(self, action: #selector(dismissvc), for: .touchUpInside)
        return value
    }()
    
    @objc func dismissvc(){
        self.dismiss(animated: true)
    }
    
    lazy var imageView: ShowImageView = {
        let value = ShowImageView.init(datas: datas,index: index)
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        view.backgroundColor = .black
    }
    
    func makeUI(){
        
        view.addSubview(imageView)
        view.addSubview(closeBtn)
        
    }
    
    func makeLayout(){
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        closeBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(UIScreen.i_safeAreaInsets.top+8)
            make.size.equalTo(32)
        }
        
        
    }
}


struct ShowImageBrigeView: UIViewRepresentable {
    
    var index:Int = 0
    var datas:[String] = []
    
    func makeUIView(context: Context) -> ShowImageView {
        let view = ShowImageView(datas: datas,index: index)
    
        return view
    }
    
    func updateUIView(_ uiView: ShowImageView, context: Context) {
        
    }
}

struct ShowImageBrigeVC: UIViewControllerRepresentable {
    
    var index:Int = 0
    var datas:[String] = []

    
    func makeUIViewController(context: Context) -> ShowImageVC {
        debugPrint(index)
        let vc = ShowImageVC()
        vc.datas = datas
        vc.index = index
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
@available(iOS, introduced: 15.0)
struct ShowImageVC_Previews: PreviewProvider {
    static var previews: some View {
        ShowImageBrigeVC(index: 0)
            .ignoresSafeArea()
    }
}
