//
//  DefaultBlockchainObserver.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

class DefaultBlockchainObserver: BlockchainObserverInterface {
    weak var delegate: BlockchainObserverDelegate?
    var observedAddresses: Set<Address> = []
    var timer: BlocksTimer?
    
    required init(delegate: BlockchainObserverDelegate) {
        self.delegate = delegate
        timer = BlocksTimer(tick: timerTick)
    }
    
    lazy var timerTick: () -> Void = { [weak self] in
        self?.getNewBlocks()
    }
    
    func getNewBlocks() {
        fatalError("shold override")
    }
    
    // MARK: - BlockchainObserverInterface
    var asset: Asset {
        fatalError("shold override")
    }
    
    func observe(_ address: Address) {
        if observedAddresses.isEmpty {
            timer?.startTimer()
        }
        observedAddresses.insert(address)
    }
    
    func removeObserver(_ address: Address) {
        observedAddresses.remove(address)
        if observedAddresses.isEmpty {
            timer?.pauseTimer()
        }
    }
    
    func startObsering() {
        timer?.restartTimer()
    }
    
    func pauseObserving() {
        timer?.pauseTimer()
    }
    
    var isUpdating: Bool {
        return timer?.isOn ?? false
    }
}
