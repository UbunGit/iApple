//
//  MediaTableViewCell.swift
//  example
//
//  Created by admin on 2023/4/16.
//

import UIKit
import iApple
import Alamofire

class MediaTableViewCell: UITableViewCell {

    var celldata:ResourceModel!{
        didSet{
            reloadData()
        }
    }
    
    lazy var nameLab: UILabel = {
        let value = UILabel()
        return value
    }()
    lazy var descLab: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12)
        value.textColor = .secondaryLabel
        return value
    }()
    lazy var urlLab: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12)
        value.textColor = .secondaryLabel
        value.numberOfLines = 2
        return value
    }()
    lazy var lastUpdateDataLab: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12)
        value.textColor = .secondaryLabel
        return value
    }()
    lazy var stateImgView: UIImageView = {
        let value = UIImageView()
        value.image = .init(named: "start8.select")
        return value
    }()
    
    lazy var progressView: CircleProgressView = {
        let value = CircleProgressView()
        value.isHidden = true
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addObserver()
        makeUI()
        makeLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func makeUI(){
        contentView.addSubview(nameLab)
        contentView.addSubview(descLab)
        contentView.addSubview(urlLab)
        contentView.addSubview(lastUpdateDataLab)
        contentView.addSubview(stateImgView)
        contentView.addSubview(progressView)
    }
    
    func makeLayout(){
        nameLab.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
        }
        descLab.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp.bottom).offset(4)
            make.left.equalTo(nameLab)
        }
        urlLab.snp.makeConstraints { make in
            make.top.equalTo(descLab.snp.bottom).offset(4)
            make.left.equalTo(nameLab)
            make.right.equalToSuperview().offset(-16)
        }
        
        stateImgView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY).offset(-2)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(12)
        }
        lastUpdateDataLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalTo(stateImgView)
        }
        progressView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(stateImgView)
            make.size.equalTo(16)
        }
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(forName: .apiDownDidProgressChange, object: nil, queue: .main) {[weak self] notif in
            guard let self = self else {return}
            guard let userinfo = notif.userInfo,
                  let progress = userinfo["progress"] as? Progress,
                  let key = userinfo["key"] as? String else {
                return
            }
            if key != celldata.sourceUrl.absoluteString{
                return
            }
            self.progressView.isHidden = false
            self.progressView.setProgress(progress.fractionCompleted)
            self.stateImgView.isHidden = true
        }
        
        NotificationCenter.default.addObserver(forName: .apiDownDidfinesh, object: nil, queue: .main) {[weak self] notif in
            guard let self = self else {return}
            guard let userinfo = notif.userInfo,
                  let key = userinfo["key"] as? String else {
                return
            }
            if key != celldata.sourceUrl.absoluteString{
                return
            }
            self.progressView.isHidden = true
            self.stateImgView.isHidden = false
        }
        
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: .apiDownDidProgressChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: .apiDownDidfinesh, object: nil)
    }
    
    

}

extension MediaTableViewCell{
    func reloadData(){
        nameLab.text = celldata.name
        urlLab.text = celldata.sourceUrl.absoluteString
        lastUpdateDataLab.text = "最后更新时间:"+Date().i_dateString()
    }
}
