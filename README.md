# KDeepGesture
İOS Deep Press Gesture and Taptic 📳

#### Use

```Swift
        let gesture = KDeepGesture(target: self, action: #selector(booom), root: self.view)
        gesture.threshold = 0.60
        box.addGestureRecognizer(gesture)
```

```Swift
        func booom(_ sender:KDeepGesture) {
        
        if sender.isThreshold {
            // code 
        }   
    }
```

##### Get press time & press scale

```Swift
      sender.pressTime
      sender.scale
```

##### Use Taptic feedback

- [X] (Support iphone 7/7plus)

```Swift
      sender.taptic.impactTap(.light) // .light, .medium, .heavy
      sender.taptic.notificationTap(.success) // .error, .success, .warning
      sender.taptic.tap()  
```
