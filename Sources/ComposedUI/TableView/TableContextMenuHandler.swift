import UIKit
import Composed

@available(iOS 13.0, *)
public protocol TableContextMenuHandler: CollectionSectionProvider {
    func contextMenu(forItemAt index: Int, suggestedActions: [UIMenuElement]) -> UIMenu?
    func contextMenu(previewForItemAt index: Int, cell: UITableViewCell) -> UIContextMenuContentPreviewProvider?
    func contextMenu(previewForHighlightingItemAt index: Int, cell: UITableViewCell) -> UITargetedPreview?
    func contextMenu(previewForDismissingItemAt index: Int, cell: UITableViewCell) -> UITargetedPreview?
    func contextMenu(willPerformPreviewActionForItemAt index: Int, animator: UIContextMenuInteractionCommitAnimating)
}

@available(iOS 13.0, *)
public extension TableContextMenuHandler {
    func contextMenu(forItemAt index: Int, suggestedActions: [UIMenuElement]) -> UIMenu? { return nil }
    func contextMenu(previewForItemAt index: Int, cell: UITableViewCell) -> UIContextMenuContentPreviewProvider? { return nil }
    func contextMenu(previewForHighlightingItemAt index: Int, cell: UITableViewCell) -> UITargetedPreview? { return nil }
    func contextMenu(previewForDismissingItemAt index: Int, cell: UITableViewCell) -> UITargetedPreview? { return nil }
    func contextMenu(willPerformPreviewActionForItemAt index: Int, animator: UIContextMenuInteractionCommitAnimating) { }
}