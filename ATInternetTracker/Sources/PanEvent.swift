/*
 This SDK is licensed under the MIT license (MIT)
 Copyright (c) 2015- Applied Technologies Internet SAS (registration number B 403 261 258 - Trade and Companies Register of Bordeaux – France)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */


import Foundation

/// class to store Pan gesture Events
class PanEvent : GestureEvent {
    
    /**
     Generic pan moves
     
     - Left:  left
     - Right: right
     - Up:    up
     - Down:  down
     */
    enum PanDirection: String {
        case Left  = "left"
        case Right = "right"
        case Up = "up"
        case Down = "down"
    }
    
    /// JSON description
    override var description: String {
        var jsonObj: [String: Any] = [
            "event": Gesture.getEventTypeRawValue(self.eventType.rawValue),
            "data":[
                "x":-1,
                "y":-1,
                "type": Gesture.getEventTypeRawValue(self.eventType.rawValue),
                "methodName": self.methodName,
                "direction": self.direction,
                "isDefaultMethod": self._methodName == nil,
                "title": self.title ?? defaultMethodName
            ]
        ]
        
        var data = jsonObj["data"] as! [String: Any]
        data.append(self.view.toJSONObject)
        data.append(self.currentScreen.toJSONObject)
        jsonObj.updateValue(data, forKey: "data")
        
        return jsonObj.toJSON()
    }
    
    /**
     Init a Pan Event
     
     - parameter view:          a View where the pan was detected
     - parameter direction:     the direction of the pan event
     - parameter currentScreen: the screen where the pan occured
     
     - returns: a PanEvent
     */
    init(view: View, direction: PanDirection, currentScreen: Screen, methodName: String?) {
        super.init(type: Gesture.GestureEventType.pan, methodName: methodName, view: view, direction: direction.rawValue, currentScreen: currentScreen)
        self.defaultMethodName = "handlePan:"
    }
}
