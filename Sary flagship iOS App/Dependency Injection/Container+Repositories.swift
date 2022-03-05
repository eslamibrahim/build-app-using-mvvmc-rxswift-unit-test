//
//  Container+Repositories.swift
//  Sehatty
//
//  Created by islam ibrahim on 04/01/1443 AH.
//  Copyright © 1443 Lean. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerRepositories() {
       autoregister(SaryHomeRepository.self, initializer: SaryHomeDataRepository.init).inObjectScope(.container)
    }
}
