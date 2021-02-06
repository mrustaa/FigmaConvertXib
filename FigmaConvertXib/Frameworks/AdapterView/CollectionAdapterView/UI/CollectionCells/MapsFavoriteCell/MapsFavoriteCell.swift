


import UIKit

class MapsFavoriteItem: CollectionAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         image: UIImage? = nil,
         clickCallback: (() -> Void)? = nil) {
        
        let cellData = MapsFavoriteCellData(title, subtitle, image, clickCallback)
        
        super.init(cellClass: MapsFavoriteCell.self, cellData: cellData)
    }
}


class MapsFavoriteCellData: CollectionAdapterCellData {
    
    // MARK: Properties
    
    public let title: String
    public let subTitle: String
    public let image: UIImage?
    public var clickCallback: (() -> Void)?
    
    // MARK: Inits
    
    public init (_ title: String?,
                 _ subTitle: String?,
                 _ image: UIImage?,
                 _ clickCallback: (() -> Void)?) {
        
        self.title = title ?? ""
        self.subTitle = subTitle ?? ""
        self.image = image
        self.clickCallback = clickCallback
        
        super.init()
    }
    
    override public func size() -> CGSize {
        return CGSize(width: 86, height: 137)
    }
}

class MapsFavoriteCell: CollectionAdapterCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageButton: DesignButton?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    // MARK: Properties
    
    public var data: MapsFavoriteCellData?
    
    override func awakeFromNib() { }
    
    override func fill(data: Any?) {
        guard let data = data as? MapsFavoriteCellData else { return }
        self.data = data
        
        titleLabel?.text = data.title
        subtitleLabel?.text = data.subTitle
    }
}
