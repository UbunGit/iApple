//
//  ISettingBannedUserVC.swift
//  iApple
//
//  Created by admin on 2023/7/26.
//

import UIKit

class ISettingBannedUserVC: UIViewController {

    lazy var remarkLab: UILabel = {
        let value = UILabel()
        value.text = "确定要注销此平台账号信息吗?"
        value.textColor = .label
        value.font = .systemFont(ofSize: 24,weight: .black)
        value.numberOfLines = 0

        return value
    }()
    lazy var desLab: UILabel = {
        let value = UILabel()
        let text = """
注销成功后，您的账号将：

1.无法登录、使用该账号，无法找回或者处置该账号中及账号相关的任何内容、信息或资产，即便重新注册也是一个全新的账号；

2.您对账号的注销行为将视为您资源、主动放弃包括个人信息、会员等信息和资产的虛拟杈益，因此请您在申请注销前自行备份并妥善处理相关信息和事宜；

3.注销期间，如果经核查发现您的账号存在未结的争议纠纷，包括但不限于被投诉、举报或违反法律法规等，我们有权拒绝您的账号注销申请布无需另行得到您的同意；

4.注销完成后，我们将在一周内依法删除您的个人信息或对其进行匿名化处理，法律法规另有规定的除外。
"""
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        var att = NSMutableAttributedString.init(string: text)
        att.addAttributes([.paragraphStyle:style], range: .init(location: 0, length: text.count))
        value.attributedText = att
        value.textColor = .label
        value.font = .systemFont(ofSize: 14)
        value.numberOfLines = 0
        return value
    }()

  

    lazy var commitBtn: UIButton = {
        let value = UIButton()
        value.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        value.setTitle("确定注销", for: .normal)
        value.setTitleColor(.white, for: .normal)
        value.backgroundColor = view.tintColor
        value.i_radius = 12
        return value
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注销账号"
        makeUI()
        makeLayout()

    }
    func makeUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(remarkLab)
        view.addSubview(commitBtn)
        view.addSubview(desLab)
    }
    func makeLayout(){
        remarkLab.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        desLab.snp.makeConstraints { make in
          
            make.top.equalTo(remarkLab.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        commitBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.size.equalTo(CGSize(width: 280, height: 52))
            make.centerX.equalToSuperview()
        }
    }

}
class ISettingBannedUserDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
