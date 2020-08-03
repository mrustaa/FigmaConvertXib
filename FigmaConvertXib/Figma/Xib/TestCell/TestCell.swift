import UIKit

// MARK: - Item

class TestCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         separator: Bool = false,
         touchAnimationHide: Bool = false,
         editing: Bool = false,
         clickCallback: (() -> ())? = nil) {
        
        let cellData = TestCellCellData(title, subtitle, separator, touchAnimationHide, editing, clickCallback)
        
        super.init(cellClass: TestCellCell.self, cellData: cellData)
    }
}

// MARK: - Data

class TestCellCellData: TableAdapterCellData {
    
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
        return 90.0
    }
    
    override public func canEditing() -> Bool {
        return editing
    }
}

// MARK: - Cell

class TestCellCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: TestCellCellData?
    
    // MARK: Outlets
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?

    @IBOutlet override var selectedView: UIView? { didSet { } }
    @IBOutlet private weak var separatorView: UIView?
    @IBOutlet private weak var separatorHeightConstraint: NSLayoutConstraint?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorView?.backgroundColor = .clear
        separatorHeightConstraint?.constant = 0.5
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? TestCellCellData else { return }
        self.data = data
        
        self.hideAnimation = data.touchAnimationHide
        separatorView?.isHidden = !data.separatorVisible
        
        titleLabel?.text = data.title
        subtitleLabel?.text = data.subtitle
        
    }
}