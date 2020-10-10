/*
WunderLINQ Client Application
Copyright (C) 2020  Keith Conger, Black Box Embedded, LLC

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var taskImage: UIImageView!
    public var icon: UIImageView!
    public var label: UILabel!
    
    func displayContent(icon: UIImage) {
        taskImage.image = icon
        taskImage.tintColor = UIColor(named: "imageTint")
        
        taskImage.transform = CGAffineTransform.identity
        if UIDevice.current.orientation.isPortrait {
            taskImage.transform = taskImage.transform.rotated(by: CGFloat(.pi / 2.0))
        }
    }
    
    func highlightEffect(){
        
        uiView.layer.cornerRadius = (uiView.frame.size.height / 2.0)
        uiView.clipsToBounds = true
        uiView.layer.masksToBounds = false
        uiView.layer.borderWidth = 0
        
        var highlightColor: UIColor?
        if let colorData = UserDefaults.standard.data(forKey: "highlight_color_preference"){
            highlightColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        } else {
            highlightColor = UIColor(named: "accent")
        }
        
        uiView.backgroundColor = highlightColor

        taskImage.tintColor = UIColor.white
    }
    
    func removeHighlight(){
        uiView.backgroundColor = UIColor.clear
        
        if #available(iOS 13.0, *) {
            taskImage.tintColor = UIColor(named: "imageTint")
        } else {
            switch(UserDefaults.standard.integer(forKey: UserPreferences.darkMode.rawValue)){
            case 0:
                //OFF
                taskImage.tintColor = UIColor.black
            case 1:
                //On
                taskImage.tintColor = UIColor.white
            default:
                //Default
                taskImage.tintColor = UIColor.black
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
    }
}
