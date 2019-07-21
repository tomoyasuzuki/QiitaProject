//
//  HistoryViewModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

class HisotryViewModel {
    
    var history: [Item] = []
    
    private var historyRelay: PublishRelay<[Item]> = PublishRelay<[Item]>()
    var historyDriver: Driver<[Item]> { return historyRelay.asDriver(onErrorDriveWith: Driver.empty())}
    
    func getHistory() {
        // Firebaseのデータベースを参照する
        // 通知を出す
    }
}
