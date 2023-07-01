//
//  RealmAPI.swift
//  example
//
//  Created by mac on 2023/4/19.
//

import Foundation
import DoraemonKit
import CloudKit
extension UIApplication{
    public func seuUPdorkit(){
        DoraemonManager.shareInstance().addPlugin(withTitle: "自定义", icon: "doraemon_default", desc: "自定义", pluginName: "", atModule: "自定义"){_ in
            let vc = DotKitViewcontroller()
            DoraemonHomeWindow.openPlugin(vc)
        }
        DoraemonManager.shareInstance().addPlugin(withTitle: "自定义", icon: "doraemon_default", desc: "自定义", pluginName: "", atModule: "自定义") { _ in
            
        }
        DoraemonManager.shareInstance().install()
    }
}


class DotKitViewcontroller:UIViewController{
    lazy var tableView: UITableView = {
        let value = UITableView()
        value.delegate = self
        value.dataSource = self
        value.i_registerCell(UITableViewCell.self)
        return value
    }()
    let dataSouce:[String] = [
        "app://home"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "自定义测试"
        makeUI()
        makeLayout()
    }
    func makeUI(){
        view.addSubview(tableView)
    }
    func makeLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DotKitViewcontroller:I_UITableViewProtocol{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.i_dequeueReusableCell(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = dataSouce[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celldata = dataSouce[indexPath.row]
        guard let vc = UIViewController.i_initWith(urlStr: celldata) else {
            view.tost(msg: "未找到对应的页面")
            return
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}




