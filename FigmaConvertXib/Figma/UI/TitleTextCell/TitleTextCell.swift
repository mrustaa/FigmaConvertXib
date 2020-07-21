



import UIKit



// MARK: - Item

class TitleTextItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         separator: Bool = false,
         touchAnimationHide: Bool = false,
         editing: Bool = false,
         clickCallback: (() -> ())? = nil) {
        
        let cellData = TitleTextCellData(title, subtitle, separator, touchAnimationHide, editing, clickCallback)
        
        super.init(cellClass: TitleTextCell.self, cellData: cellData)
    }
}

// MARK: - Data

class TitleTextCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var subtitle: String?
    var separatorVisible: Bool
    var touchAnimationHide: Bool
    
    var editing: Bool
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ subtitle: String? = nil,
         _ separator: Bool,
         _ touchAnimationHide: Bool,
         _ editing: Bool,
         _ clickCallback: (() -> ())?) {
        
        self.title = title
        self.subtitle = subtitle
        
        self.separatorVisible = separator
        self.touchAnimationHide = touchAnimationHide
        self.editing = editing
        
        super.init(clickCallback)
    }
    
    override public func cellHeight() -> CGFloat {
        if title != nil {
            return 64
        } else {
            return 44
        }
    }
    
    override public func canEditing() -> Bool {
        return editing
    }
}

// MARK: - Cell

class TitleTextCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: TitleTextCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? { didSet { } }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var separatorView: UIView?
    @IBOutlet private weak var separatorHeightConstraint: NSLayoutConstraint?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorView?.backgroundColor = .clear
        separatorHeightConstraint?.constant = 0.5
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? TitleTextCellData else { return }
        self.data = data
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .green
        editingAccessoryView = view

        self.hideAnimation = data.touchAnimationHide
        
        titleLabel?.text = data.title
        subtitleLabel?.text = data.subtitle
        
        separatorView?.isHidden = !data.separatorVisible
    }
}
