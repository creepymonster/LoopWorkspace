//
//  Locked.swift
//  TidepoolKit
//
//  Copyright © 2018 LoopKit Authors. All rights reserved.
//

import os.lock

final class Locked<T> {
    private var _lock: UnfairLock
    private var _value: T

    init(_ value: T) {
        self._lock = UnfairLock()
        self._value = value
    }

    var value: T {
        get { _lock.locked { _value } }
        set { _lock.locked { _value = newValue } }
    }

    @discardableResult func mutate(_ changes: (_ value: inout T) -> Void) -> T {
        return _lock.locked {
            changes(&_value)
            return _value
        }
    }
}
