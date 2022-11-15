import UIKit

protocol StoryboardInstantiable: UIViewController {}

extension StoryboardInstantiable {
    static func instantiate(storyboardName: String) -> Self {
        guard let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as? Self else {
            fatalError("There is no Storyboard named \(storyboardName) with this initial View Controller.")
        }
        
        return storyboard
    }
}
