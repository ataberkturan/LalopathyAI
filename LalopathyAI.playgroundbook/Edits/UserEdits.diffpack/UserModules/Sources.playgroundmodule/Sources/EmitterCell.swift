
import SwiftUI

// EmitterLayer cell creation function.
public func cell(content: CGImage) -> CAEmitterCell {
    // Cell identification.
    let cell = CAEmitterCell()
    
    // Setting the cell properties.
    cell.contents = content
    cell.birthRate = 1.0
    cell.lifetime = 20.0
    cell.velocity = 10.0
    cell.velocityRange = -15.0
    cell.yAcceleration = 5.0
    cell.emissionRange = 180.0 * (.pi / 180.0)
    cell.scale = 0.06
    cell.scaleRange = 0.3
    cell.color = UIColor.white.cgColor
    
    return cell
}
