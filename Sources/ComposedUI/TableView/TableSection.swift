import UIKit
import Composed

public enum TableHeaderFooter<View> where View: UITableViewHeaderFooterView {
    case title(String)
    case element(TableElement<View>)
}

open class TableSection: TableElementsProvider {

    public let cell: TableElement<UITableViewCell>
    public let header: TableElement<UITableViewHeaderFooterView>?
    public let footer: TableElement<UITableViewHeaderFooterView>?

    open var numberOfElements: Int {
        return section?.numberOfElements ?? 0
    }

    private weak var section: Section?

    public init<Section, Cell, Header, Footer>(section: Section,
                                               cell: TableElement<Cell>,
                                               header: TableHeaderFooter<Header>? = nil,
                                               footer: TableHeaderFooter<Footer>? = nil)
        where Section: Composed.Section, Cell: UITableViewCell, Header: UITableViewHeaderFooterView, Footer: UITableViewHeaderFooterView {
            self.section = section

            let dequeueMethod: DequeueMethod<UITableViewCell>
            switch cell.dequeueMethod {
            case .class: dequeueMethod = .class(Cell.self)
            case .nib: dequeueMethod = .nib(Cell.self)
            case .storyboard: dequeueMethod = .storyboard(Cell.self)
            }

            self.cell = TableElement(section: section,
                                     dequeueMethod: dequeueMethod,
                                     reuseIdentifier: cell.reuseIdentifier,
                                     configure: cell.configure)

            switch header {
            case .none:
                self.header = nil
            case let .title(title):
                self.header = TableElement(section: section, dequeueMethod: .class(Header.self)) { view, _, _ in
                    view.textLabel?.text = title
                }
            case let .element(element):
                let dequeueMethod: DequeueMethod<UITableViewHeaderFooterView>
                switch element.dequeueMethod {
                case .class: dequeueMethod = .class(Header.self)
                case .nib: dequeueMethod = .nib(Header.self)
                case .storyboard: dequeueMethod = .storyboard(Header.self)
                }

                self.header = TableElement(section: section,
                                           dequeueMethod: dequeueMethod,
                                           reuseIdentifier: element.reuseIdentifier,
                                           configure: element.configure)
            }

            switch footer {
            case .none:
                self.footer = nil
            case let .title(title):
                self.footer = TableElement(section: section, dequeueMethod: .class(Footer.self)) { view, _, _ in
                    view.textLabel?.text = title
                }
            case let .element(element):
                let dequeueMethod: DequeueMethod<UITableViewHeaderFooterView>
                switch element.dequeueMethod {
                case .class: dequeueMethod = .class(Footer.self)
                case .nib: dequeueMethod = .nib(Footer.self)
                case .storyboard: dequeueMethod = .storyboard(Footer.self)
                }

                self.footer = TableElement(section: section,
                                           dequeueMethod: dequeueMethod,
                                           reuseIdentifier: element.reuseIdentifier,
                                           configure: element.configure)
            }
    }

}
