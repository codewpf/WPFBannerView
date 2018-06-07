//
//  SwiftTimer.swift
//  SwiftTimer
//
//  Created by mangofang on 16/8/23.
//
//  From https://github.com/100mango/SwiftTimer
//  Modify the file name for WPFTimer on 17/6/14 by Alex.
//  Update something.

import Foundation

public class WPFTimer {
    
    private let internalTimer: DispatchSourceTimer
    
    private var isRunning = false
    
    public let repeats: Bool
    
    public typealias WPFTimerHandler = (WPFTimer) -> Void
    
    private var handler: WPFTimerHandler
    
    public init(interval: DispatchTimeInterval, repeats: Bool = false, queue: DispatchQueue = .main , handler: @escaping WPFTimerHandler) {
        
        self.handler = handler
        self.repeats = repeats
        internalTimer = DispatchSource.makeTimerSource(queue: queue)
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        
        if repeats {
            internalTimer.schedule(deadline: .now() + interval, repeating: interval)
        } else {
            internalTimer.schedule(deadline: .now() + interval, repeating: .never)
        }
    }
    
    public static func repeaticTimer(interval: DispatchTimeInterval, queue: DispatchQueue = .main , handler: @escaping WPFTimerHandler ) -> WPFTimer {
        return WPFTimer(interval: interval, repeats: true, queue: queue, handler: handler)
    }
    
    deinit {
        if !self.isRunning {
            internalTimer.resume()
        }
    }
    
    //You can use this method to fire a repeating timer without interrupting its regular firing schedule. If the timer is non-repeating, it is automatically invalidated after firing, even if its scheduled fire date has not arrived.
    public func fire() {
        if repeats {
            handler(self)
        } else {
            handler(self)
            internalTimer.cancel()
        }
    }
    
    public func start() {
        if !isRunning {
            internalTimer.resume()
            isRunning = true
        }
    }
    
    public func suspend() {
        if isRunning {
            internalTimer.suspend()
            isRunning = false
        }
    }
    
    public func cancel() {
        if internalTimer.isCancelled != true {
            internalTimer.cancel()
        }
    }
    
    public func rescheduleRepeating(interval: DispatchTimeInterval) {
        if repeats {
            internalTimer.schedule(deadline: .now() + interval, repeating: interval)
        }
    }
    
    public func rescheduleHandler(handler: @escaping WPFTimerHandler) {
        self.handler = handler
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        
    }
}

//MARK: Throttle
public extension WPFTimer {
    
    private static var timers = [String:DispatchSourceTimer]()
    
    public static func throttle(interval: DispatchTimeInterval, identifier: String, queue: DispatchQueue = .main , handler: @escaping () -> Void ) {
        
        if let previousTimer = timers[identifier] {
            previousTimer.cancel()
        }
        
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now() + interval, repeating: .never)
        timer.setEventHandler {
            handler()
            timer.cancel()
            timers.removeValue(forKey: identifier)
        }
        timer.resume()
        timers[identifier] = timer
    }
}

//MARK: Count Down
public class WPFCountDownTimer {
    
    let internalTimer: WPFTimer
    
    var leftTimes: Int
    
    let originalTimes: Int
    
    let handler: (WPFCountDownTimer, _ leftTimes: Int) -> Void
    
    public init(interval: DispatchTimeInterval, times: Int,queue: DispatchQueue = .main , handler:  @escaping (WPFCountDownTimer, _ leftTimes: Int) -> Void ) {
        
        self.leftTimes = times
        self.originalTimes = times
        self.handler = handler
        self.internalTimer = WPFTimer.repeaticTimer(interval: interval, queue: queue, handler: { _ in
        })
        self.internalTimer.rescheduleHandler { [weak self]  WPFTimer in
            if let strongSelf = self {
                if strongSelf.leftTimes > 0 {
                    strongSelf.leftTimes = strongSelf.leftTimes - 1
                    strongSelf.handler(strongSelf, strongSelf.leftTimes)
                } else {
                    strongSelf.internalTimer.suspend()
                }
            }
        }
    }
    
    public func start() {
        self.internalTimer.start()
    }
    
    public func suspend() {
        self.internalTimer.suspend()
    }
    
    public func reCountDown() {
        self.leftTimes = self.originalTimes
    }
    
}

public extension DispatchTimeInterval {
    
    public static func fromSeconds(_ seconds: Double) -> DispatchTimeInterval {
        return .nanoseconds(Int(seconds * Double(NSEC_PER_SEC)))
    }
}
