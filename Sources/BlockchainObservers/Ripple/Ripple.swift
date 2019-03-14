//
//  Ripple.swift
//  BlockObserver
//
//  Created by Pavlo Boiko on 3/13/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

import Foundation

internal class RippleBlockchainObserver: DefaultBlockchainObserver {
    override var asset: Asset { return .ripple }

}
